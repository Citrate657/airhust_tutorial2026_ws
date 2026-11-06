// 3.3 参考答案
#include <pcl/filters/crop_box.h>
#include <pcl/filters/passthrough.h>
#include <pcl/filters/statistical_outlier_removal.h>
#include <pcl/filters/voxel_grid.h>
#include <pcl/io/pcd_io.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>

#include <algorithm>
#include <cmath>
#include <iostream>
#include <stdexcept>
#include <string>

#include "pcl_basic/path.hpp"

using Cloud = pcl::PointCloud<pcl::PointXYZI>;

// 文件输入；连续处理时，这一步换成接收新一帧。
void readCloud(const std::string& path, Cloud& output) {
  if (pcl::io::loadPCDFile(path, output) < 0)
    throw std::runtime_error("读取失败: " + path);
  auto& points = output.points;
  points.erase(std::remove_if(points.begin(), points.end(), [](const auto& point) {
    return !std::isfinite(point.x) || !std::isfinite(point.y) || !std::isfinite(point.z);
  }), points.end());
  output.width = static_cast<std::uint32_t>(points.size());
  output.height = 1;
  output.is_dense = true;
  if (output.empty()) throw std::runtime_error("点云没有有限坐标");
}

void saveCloud(const Cloud& cloud, const std::string& file) {
  if (cloud.empty()) throw std::runtime_error("没有点可保存: " + file);
  if (pcl::io::savePCDFileBinary(outPath(file), cloud) < 0)
    throw std::runtime_error("保存失败: " + file);
  std::cout << "存到 " << outPath(file) << "\n";
}

void downsample(const Cloud::ConstPtr& cloud, Cloud& output, float leaf) {
  output.clear();
  if (cloud->empty()) return;
  pcl::VoxelGrid<pcl::PointXYZI> vg;
  vg.setInputCloud(cloud);
  vg.setLeafSize(leaf, leaf, leaf);
  vg.filter(output);
}

void denoise(const Cloud::ConstPtr& cloud, Cloud& output, int mean_k, double stddev) {
  output.clear();
  if (cloud->empty()) return;
  pcl::StatisticalOutlierRemoval<pcl::PointXYZI> sor;
  sor.setInputCloud(cloud);
  sor.setMeanK(mean_k);
  sor.setStddevMulThresh(stddev);
  sor.filter(output);
}

void region(const Cloud::ConstPtr& cloud, Cloud& output) {
  output.clear();
  if (cloud->empty()) return;
  pcl::CropBox<pcl::PointXYZI> crop;
  crop.setInputCloud(cloud);
  crop.setMin(Eigen::Vector4f(1.8f, 1.8f, 0.60f, 1.0f));
  crop.setMax(Eigen::Vector4f(3.5f, 4.5f, 1.20f, 1.0f));
  crop.filter(output);
}

int main(int argc, char** argv) try {
  // 先创建输入和中间结果容器，处理函数内部不创建点云。
  auto raw = pcl::make_shared<Cloud>();
  auto sampled = pcl::make_shared<Cloud>();
  auto denoised = pcl::make_shared<Cloud>();
  auto objects = pcl::make_shared<Cloud>();

  // 读取一帧。
  readCloud(argc > 1 ? argv[1] : dataPath("demo_room_noisy.pcd"), *raw);
  std::cout << "原始点数        : " << raw->size() << "\n";
  // 体素降采样。
  downsample(raw, *sampled, 0.05f);
  std::cout << "体素降采样后    : " << sampled->size() << "\n";
  // 统计去噪。
  denoise(sampled, *denoised, 20, 1.0);
  std::cout << "统计离群点去除后: " << denoised->size() << "\n";
  // 保存去噪后的点云，方便对比。
  saveCloud(*denoised, "03_denoised.pcd");
  // 提取区域。
  region(denoised, *objects);
  std::cout << "区域内点数      : " << objects->size() << "\n";
  // 保存区域内的点。
  saveCloud(*objects, "03_region.pcd");
  return 0;
} catch (const std::exception& e) {
  std::cerr << e.what() << "\n";
  return 1;
}

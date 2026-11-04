// 3.1 参考答案
#include <pcl/common/common.h>
#include <pcl/io/pcd_io.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>

#include <iostream>
#include <string>

#include "pcl_basic/path.hpp"

int main(int argc, char** argv) {
  const std::string path = (argc > 1) ? argv[1] : dataPath("demo_room.pcd");
  pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);
  if (pcl::io::loadPCDFile<pcl::PointXYZI>(path, *cloud) == -1) {
    std::cerr << "读不了 " << path << "\n";
    return 1;
  }

  if (cloud->empty()) {
    std::cerr << "点云为空\n";
    return 1;
  }

  std::cout << "点数     : " << cloud->size() << "\n";
  std::cout << "width    : " << cloud->width << "\n";
  std::cout << "height   : " << cloud->height << "\n";
  std::cout << "is_dense : " << cloud->is_dense << "\n";

  pcl::PointXYZI min_pt, max_pt;
  pcl::getMinMax3D(*cloud, min_pt, max_pt);
  std::cout << "包围盒 x [" << min_pt.x << ", " << max_pt.x << "]  y ["
            << min_pt.y << ", " << max_pt.y << "]  z [" << min_pt.z << ", "
            << max_pt.z << "]\n";

  const pcl::PointXYZI& p = cloud->points[0];
  std::cout << "第 0 个点 (" << p.x << ", " << p.y << ", " << p.z << ")  intensity "
            << p.intensity << "\n";

  if (pcl::io::savePCDFileBinary(outPath("01_copy.pcd"), *cloud) < 0) return 1;
  std::cout << "存到 " << outPath("01_copy.pcd") << "\n";
  return 0;
}

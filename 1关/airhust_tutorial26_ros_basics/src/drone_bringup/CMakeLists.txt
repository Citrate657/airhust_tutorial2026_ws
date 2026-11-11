cmake_minimum_required(VERSION 3.0.2)
project(drone_bringup)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  geometry_msgs
  std_msgs
  drone_backend
)

catkin_package(
  CATKIN_DEPENDS roscpp geometry_msgs std_msgs drone_backend
)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(example_listener src/example_listener.cpp)
target_link_libraries(example_listener ${catkin_LIBRARIES})

add_executable(flight_node src/flight_node.cpp)
target_link_libraries(flight_node ${catkin_LIBRARIES})
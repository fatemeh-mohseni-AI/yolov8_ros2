#!/bin/bash

#  docker build --tag yolov8_ros:humble .
xhost +local:docker

docker run --name iprocessing --rm \
  --network host \
  -v .:/yolo_ws/src/ros2_yolov8 \
  yolov8_ros:humble /bin/bash -c \
  "cd /yolo_ws && colcon build && bash"


# ros2 launch yolov8_bringup yolov8.launch.py model:=yolov8m-seg.pt
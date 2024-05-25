#!/bin/bash

docker run --name vision \
  --rm --net=host --privileged --runtime nvidia \
  -d \
  -v /home/jetson/yolov8_ros2/test/video.mp4:/root/ros2_ws/src/Ros2_Yolov8/test/video.mp4 \
  -v /home/jetson/yolov8_ros2/model/best.pt:/root/ros2_ws/src/Ros2_Yolov8/model/best.pt \
  vision:foxy-arm

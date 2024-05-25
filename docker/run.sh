#!/bin/bash

docker run --name vision \
  --rm --net=host --privileged \
  -d \
  -v /home/fatemeh/develop/yolov8_ros/test/video.mp4:/root/ros2_ws/src/Ros2_Yolov8/test/video.mp4 \
  -v /home/fatemeh/develop/yolov8_ros/model/best.pt:/root/ros2_ws/src/Ros2_Yolov8/model/best.pt \
  vision:foxy-amd

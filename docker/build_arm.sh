#!/bin/bash

docker build --platform linux/arm64 \
  --tag vision:foxy-amd \
  -f /home/jetson/yolov8_ros2/Dockerfile-arm \
  .
#!/bin/bash

docker build --platform linux/arm64 \
  --tag vision:foxy-amd \
  -f /home/fatemeh/develop/yolov8_ros/Dockerfile-arm \
  .
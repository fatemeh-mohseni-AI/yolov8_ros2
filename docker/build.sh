#!/bin/bash

docker build --platform linux/amd64 \
  --tag vision:foxy-amd \
  -f /home/fatemeh/develop/yolov8_ros/Dockerfile-amd \
  .
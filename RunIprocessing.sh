#!/bin/bash

#  docker build --tag yolov8_ros:humble .
xhost +local:docker

docker run -it --rm --name iprocessing \
  --net=host --ipc=host --pid=host \
  --privileged --env="XAUTHORITY=$XAUTH" \
  -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
  -v .:/yolo_ws/src/ros2_yolov8 \
  yolov8_ros:humble /bin/bash -c \
  "cd /yolo_ws && colcon build && bash"
#  --gpus all \


# ros2 launch yolov8_bringup yolov8.launch.py model:=yolov8m-seg.pt
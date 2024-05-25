#!/bin/bash

# Source ROS 2 setup script
source /opt/ros/foxy/setup.bash

# Source your workspace setup script
source ~/ros2_ws/install/setup.bash

# Run the ROS 2 launch command in the background
#ros2 launch yolov8_bringup yolov8.launch.py model:=yolov8m-seg.pt &

# Run the Python video publisher script
python3 ~/ros2_ws/src/Ros2_Yolov8/test/player.py

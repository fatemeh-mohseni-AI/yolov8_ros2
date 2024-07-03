#   HELP
#   https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypecache >> for apt cache
#
FROM --platform=linux/amd64 ros:humble-ros-base

ENV repo=/yolo_ws/src/ros2_yolov8
ENV wd=/yolo_ws
ENV ROS_DISTRO=humble

RUN mkdir -p $repo
WORKDIR $wd

COPY ./requirements.txt $repo

# Add ROS 2 package repositories
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get install -y software-properties-common nano && \
    add-apt-repository universe && \
    apt-add-repository restricted && \
    apt-add-repository multiverse && \
    apt-get update && \
    apt-get install -y --no-install-recommends  \
      python3-pip \
      python3-rosdep \
      python-is-python3 \
      ros-${ROS_DISTRO}-rviz2 \
      ros-${ROS_DISTRO}-ament-cmake \
      ros-${ROS_DISTRO}-rclpy \
      ros-${ROS_DISTRO}-sensor-msgs \
      ros-${ROS_DISTRO}-cv-bridge \
      ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/root/.cache/pip && \
    cd $repo && \
    pip3 install --no-cache-dir -r requirements.txt && \
    pip3 install --no-cache-dir -U rosdep colcon-common-extensions

RUN rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y

# Source ROS 2 environment
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc
RUN echo "source ${wd}/install/setup.bash" >> /root/.bashrc


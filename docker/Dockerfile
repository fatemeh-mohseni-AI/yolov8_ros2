# ----------------------------------------------------------------------------------------------------------------------
#
#  this project uses ultralytics and ultralytics needs opencv>=4.6.0
#  although all timongentzsch images have opencv==4.5.2 .
#  here we build opencv==4.6.0 and ros-foxy manually
# due to filttering and sanctions I couldn't build this file :) so i just install opencv with pip ; hencd , it's not
#                                cuda compatible . but doesn't matter for now
#
# ----------------------------------------------------------------------------------------------------------------------

FROM --platform=linux/arm64 timongentzsch/l4t-ubuntu20-base


ENV DEBIAN_FRONTEND=noninteractive
ENV OPEN_CV_VERSION=4.6.0
ENV FOLDER="/root/workspace"

ARG ROS_PKG=ros_base
ARG ROS_DISTRO=foxy
ARG ROS_ROOT=/opt/ros/${ROS_DISTRO}

ENV repo=/root/ros2_ws/src/Ros2_Yolov8
ENV wd=/root/ros2_ws

ENV LANG=en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

# --------------------------------------------------------------------------------------------
# first install opencv
# --------------------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      locales \
      build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev\
      libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev\
      python3.8-dev python-dev python-numpy python3-numpy\
      libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev\
      libv4l-dev v4l-utils qv4l2 \
      curl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN mkdir -p $FOLDER
WORKDIR $FOLDER
RUN curl -L https://github.com/opencv/opencv/archive/${OPEN_CV_VERSION}.zip -o opencv-${OPEN_CV_VERSION}.zip && \
    curl -L https://github.com/opencv/opencv_contrib/archive/${OPEN_CV_VERSION}.zip -o opencv_contrib-${OPEN_CV_VERSION}.zip && \
    unzip opencv-${OPEN_CV_VERSION}.zip && \
    unzip opencv_contrib-${OPEN_CV_VERSION}.zip && \
    rm opencv-${OPEN_CV_VERSION}.zip opencv_contrib-${OPEN_CV_VERSION}.zip && \
    cd opencv-${OPEN_CV_VERSION}/ && \
    mkdir release && \
    cd release/ && \
    cmake -D WITH_CUDA=ON -D WITH_CUDNN=ON -D CUDA_ARCH_BIN="7.2,8.7" -D CUDA_ARCH_PTX="" -D OPENCV_GENERATE_PKGCONFIG=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPEN_CV_VERSION}/modules -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python3=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && \
    make install

RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc && \
    echo 'export PYTHONPATH=/usr/local/lib/python3.8/site-packages/:$PYTHONPATH' >> ~/.bashrc

# --------------------------------------------------------------------------------------------
# install ros-foxy
# --------------------------------------------------------------------------------------------

# change the locale from POSIX to UTF-8
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# add the ROS deb repo to the apt sources list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		curl \
		wget \
		gnupg2 \
		lsb-release \
		ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#
# install ros2 packages
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		ros-${ROS_DISTRO}-ros-base \
		python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
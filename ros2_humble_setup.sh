#!/usr/bin/env bash


sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

sudo apt update
sudo apt upgrade -y



# Install ROS 2 from debs + build tools so colcon exists later
sudo apt install -y ros-humble-desktop ros-humble-ros-base python3-colcon-common-extensions ros-dev-tools

# Persist system-level sourcing (do this once)
grep -q 'source /opt/ros/humble/setup.bash' ~/.bashrc || \
  echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
# Source for current shell
source /opt/ros/humble/setup.bash


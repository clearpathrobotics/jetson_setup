#!/usr/bin/env bash

############## ADD ROS KINETIC SOURCE ##############
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

############## ADD CP SOURCE ##############
wget https://packages.clearpathrobotics.com/public.key -O - | sudo apt-key add -
sudo sh -c 'echo "deb https://packages.clearpathrobotics.com/stable/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/clearpath-latest.list'
sudo apt-get install apt-transport-https

############## UPDATE ##############
sudo apt-get update

############## ROS ##############
sudo apt-get install ros-kinetic-desktop-full

############## SETUP ROS ENVIRONMENT ##############
sudo mkdir -p /etc/ros

cat <<EOF >> /etc/profile.d/clearpath-ros-environment.sh
source /etc/ros/setup.bash
EOF

cat <<EOF > /etc/ros/setup.bash
# Mark location of self so that robot_upstart knows where to find the setup file.
export ROBOT_SETUP=/etc/ros/setup.bash

# Setup robot upstart jobs to use the IP from the network bridge.
# export ROBOT_NETWORK=br0

# Insert extra platform-level environment variables here. The six hashes below are a marker
# for scripts to insert to this file.
######

# Pass through to the main ROS workspace of the system.
source /opt/ros/kinetic/setup.bash
EOF

############## UDEV AND CONVENIENCE ##############
wget -O /home/nvidia/.screenrc http://gitlab/research/clearpath_iso/raw/master/clearpath/files/skel/.screenrc
wget -O /home/nvidia/.vimrc http://gitlab/research/clearpath_iso/raw/master/clearpath/files/skel/.vimrc
sudo wget -O /etc/udev/rules.d/10-microstrain.rules http://gitlab/research/clearpath_iso/raw/master/clearpath/files/10-microstrain.rules
sudo wget -O /etc/udev/rules.d/41-clearpath.rules http://gitlab/research/clearpath_iso/raw/master/clearpath/files/41-clearpath.rules
sudo wget -O /etc/udev/rules.d/41-hokuyo.rules http://gitlab/research/clearpath_iso/raw/master/clearpath/files/41-hokuyo.rules
sudo wget -O /etc/udev/rules.d/52-ftdi.rules http://gitlab/research/clearpath_iso/raw/master/clearpath/files/52-ftdi.rules
sudo wget -O /etc/udev/rules.d/60-startech.rules http://gitlab/research/clearpath_iso/raw/master/clearpath/files/60-startech.rules

############## DS4 ##############
mkdir ~/ds4
cd ~/ds4
git clone https://github.com/clearpathrobotics/ds4drv.git --branch xenial
sudo apt-get update
sudo apt-get install -y dpkg-dev debhelper git-buildpackage python-all-dev config-package-dev dkms
cd ds4drv
dpkg-buildpackage -uc -us
cd ..
sudo dpkg -i python-ds4drv*
cd ~
rm -rf ds4

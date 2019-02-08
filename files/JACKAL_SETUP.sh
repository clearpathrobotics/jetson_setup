#!/usr/bin/env bash

source /etc/ros/setup.bash
sudo sh -c 'echo export JACKAL_WIRELESS_INTERFACE=wlan0 >> /etc/ros/setup.bash'
rosrun jackal_bringup install

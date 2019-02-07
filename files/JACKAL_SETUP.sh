#!/usr/bin/env bash

sudo echo export JACKAL_WIRELESS_INTERFACE=wlan0 >> /etc/ros/setup.bash
rosrun jackal_bringup install

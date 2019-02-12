# jetson_setup
Simple script that makes all clearpath specific changes to a vanilla Jetson TX2 to make it operate like our robot standard images.  Makes it work as a standard computer for Husky or Jackal.

## Usage
```bash scrips/jetson_setup.sh```

## What it Does
* Add ROS sources and key
* Add Clearpath sources and key
* Installs apt-transport-https
* Installs ros-kinetic-desktop
* Installs all ROS Kinetic Husky packages
* Installs all ROS Kinetic Jackal packages
* Sets up /etc/ros/setup.bash environment (standard with CP robots)
* Adds standard vim and screen config files
* Adds udev rules for microstrain, clearpath, hukuyo, ftdi, and startech
* Adds setup script for Husky and Jackal
* Builds and installs DS4DRV driver from source
* Unblocks bluetooth

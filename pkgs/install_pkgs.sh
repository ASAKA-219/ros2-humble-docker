#! /bin/bash

set -e

#If you want to install any pkgs, you can write how to install e.g.
git clone -b humble-devel https://github.com/ROBOTIS-JAPAN-GIT/turtlebot3_lime.git
git clone -b foxy-devel https://github.com/pal-robotics/realsense_gazebo_plugin.git
git clone https://github.com/ldrobotSensorTeam/ldlidar_stl_ros2.git
exec $@

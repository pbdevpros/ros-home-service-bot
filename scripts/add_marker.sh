#!/bin/bash

home="/home/workspace/"
if [ ! -z $1 ]
then
	home=$1
fi

xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot world.launch " &
sleep 10
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot amcl.launch " &
sleep 10
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & 	# preconfigured rviz workspace
sleep 20
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun add_markers add_markers " & # draw shapes in Rviz where the pick up and drop off points are

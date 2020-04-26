#!/bin/bash

home="/home/workspace/"
if [ -z $1 ]
then
	$home=$1
fi

xterm -e " source $homecatkin_ws/devel/setup.bash ; roslaunch ros_robot world.launch " &
sleep 5
xterm -e " source $homecatkin_ws/devel/setup.bash ; roslaunch ros_robot mapping.launch " &
sleep 5
xterm -e " source $homecatkin_ws/devel/setup.bash ; roslaunch turtlebot_teleop keyboard_teleop.launch " & # launch teleop keyboard control for robot
sleep 5
# xterm -e " source $homecatkin_ws/devel/setup.bash ; roslaunch gmapping gmapping_demo.launch " 
xterm -e " source $homecatkin_ws/devel/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & # preconfigured rviz workspace
sleep 5


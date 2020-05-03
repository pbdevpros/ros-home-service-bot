#!/bin/bash

home=$(pwd)
ls ${home}/setup.bash
if [[ $? -ne 0 ]]
then
	echo "Error! setup.bash does not exist in this folder. Please call this script from folder with setup.bash script, e.g. devel/"
	exit 1
else
	echo "Sourcing setup.bash, launching ros nodes..."
fi

xterm -e " source ${home}/setup.bash ; roslaunch ros_robot world.launch " &
sleep 5
xterm -e " source ${home}/setup.bash ; roslaunch ros_robot mapping.launch " &
sleep 5
xterm -e " source ${home}/setup.bash ; rosrun teleop_twist_keyboard teleop_twist_keyboard.py " & 					# launch teleop keyboard control for robot
sleep 5
xterm -e " source ${home}/setup.bash ; rosrun gmapping slam_gmapping scan:=scan _base_frame:=robot_footprint " & 	# gmapping service
sleep 5	
xterm -e " source ${home}/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & 				# preconfigured rviz workspace
sleep 5

echo "Complete."

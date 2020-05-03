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
sleep 10
xterm -e " source ${home}/setup.bash ; roslaunch ros_robot amcl.launch " &
sleep 10
xterm -e " source ${home}/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & 	# preconfigured rviz workspace
sleep 20
xterm -e " source ${home}/setup.bash ; rosrun add_markers add_markers " & # draw shapes in Rviz where the pick up and drop off points are

echo "Complete."
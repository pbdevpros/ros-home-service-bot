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

xterm -e " source ${home}/setup.bash ; roslaunch ros_robot world.launch " & # launch gazebo world
sleep 10
xterm -e " source ${home}/setup.bash ; roslaunch ros_robot amcl.launch " & # localization robot
sleep 10
xterm -e " source ${home}/setup.bash ; roslaunch ros_robot view_navigation.launch " & 	# use rviz with markers
sleep 30
xterm -e " source ${home}/setup.bash ; rosrun pick_objects pick_objects " & # send location for autonomous navigation
sleep 5
xterm -e " source ${home}/setup.bash ; rosrun add_markers add_markers " & # draw shapes in Rviz


echo "Complete. All nodes launched."

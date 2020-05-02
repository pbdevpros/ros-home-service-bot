#!/bin/bash

home="/home/workspace/"
if [ ! -z $1 ]
then
	home=$1
fi

xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot world.launch " & # launch gazebo world
sleep 10
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot amcl.launch " & # localization robot
sleep 10
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot view_navigation.launch " & 	# use rviz with markers
sleep 30
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun pick_objects pick_objects " & # send location for autonomous navigation
sleep 10
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun add_markers add_markers " & # draw shapes in Rviz


echo "Complete. All nodes launched."

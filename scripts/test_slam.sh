#!/bin/bash

home="/home/workspace/"
if [ ! -z $1 ]
then
	home=$1
fi

xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot world.launch " &
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch ros_robot mapping.launch " &
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun teleop_twist_keyboard teleop_twist_keyboard.py " & 		# launch teleop keyboard control for robot
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun gmapping slam_gmapping scan:=scan _base_frame:=robot_footprint " & # gmapping service
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & 	# preconfigured rviz workspace
sleep 5


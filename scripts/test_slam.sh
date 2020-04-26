#!/bin/bash

home="/home/workspace/"
if [ ! -z $1 ]
then
	home=$1
fi

xterm -e " source ${home}catkin_ws/devel/setup.bash ; cd $homecatkin_ws ; roslaunch ros_robot world.launch " &
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; cd $homecatkin_ws ; roslaunch ros_robot mapping.launch " &
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch turtlebot_teleop keyboard_teleop.launch " & 		# launch teleop keyboard control for robot
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; rosrun gmapping slam_gmapping scan:=scan " & 			# gmapping service
sleep 5
xterm -e " source ${home}catkin_ws/devel/setup.bash ; roslaunch turtlebot_rviz_launchers view_navigation.launch " & 	# preconfigured rviz workspace
sleep 5


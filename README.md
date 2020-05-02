## ros-home-service-bot

### Overview

Home service robot that can autonomously guide itself around a room, in a simulated environment. 

The purpose of the project is to demonstrate the use of mapping, localization and path planning using ROS and Gazebo.

Mapping was completed using a ROS wrapper for OpenSlam's Gmapping, using the ``gmapping`` package. Localization is performed using Adaptive Monte-Carlo Localization (AMCL), based on the ```amcl``` navigational package. Path planning is performed using the ROS Navigational Stack (```navfn/NavfnROS``` , ```TrajectoryPlannerROS```), which relies on Dijkstra's algorithm, a variant of the Uniform Cost Search algorithm.

---

### Setup for Packages
```bash
$ mkdir catkin_ws
$ cd catkin_ws
$ git clone <project> src
$ cd src
$ catkin_init_workspace
```

### Installing Dependencies
Install the following ROS packages directly from source,
```bash
$ cd src
$ git clone https://github.com/ros-perception/slam_gmapping.git
$ git clone https://github.com/turtlebot/turtlebot.git
$ git clone https://github.com/turtlebot/turtlebot_interactions.git
$ git clone https://github.com/turtlebot/turtlebot_simulator.git
$ git clone https://github.com/ros-teleop/teleop_twist_keyboard.git
```

### Launching Autonomous Home Service Robot
```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/home_service.sh <homeDirectory> # Input argument is optional - should be a path to the catkin\_ws folder
```

### Notes on initial bringup

When originally setting up the packages which are used by this project, the following dependencies were pulled:
```bash
$ catkin_create_pkg add_markers roscpp visualization_msgs
...
$ catkin_create_pkg pick_objects roscpp move_base_msgs actionlib
```

Each section of the project, mapping, localization, path planning and visualization, can be tested:
```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/test_slam.sh <homeDirectory> # run gmapping SLAM package
...
$ rosrun map_server map_saver # save the map created
```

```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/test_navigation.sh <homeDirectory> # run AMCL and ROS Navigational stack 
```

```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/pick_objects.sh <homeDirectory> # run pick_objects node (give location updates to robot to autonomously move)
```

```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/add_marker.sh <homeDirectory> # run add_marker node (deprecated as it is now dependent on pick_objects)
```

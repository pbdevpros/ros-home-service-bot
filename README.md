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
$ git clone --recurse-submodules <project> src # make sure to include submodules option
$ cd src
$ catkin_init_workspace
```

### Launching Autonomous Home Service Robot
```bash
$ cd catkin_ws
$ catkin_make
$ cd devel # move to folder where setup.bash exists, to source workspace
$ ../src/scripts/home_service.sh
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
$ cd devel
$ ../src/scripts/test_slam.sh # run gmapping SLAM package
...
$ rosrun map_server map_saver # save the map created
```

```bash
$ cd catkin_ws
$ catkin_make
$ cd devel
$ ../src/scripts/test_navigation.sh # run AMCL and ROS Navigational stack 
```

```bash
$ cd catkin_ws
$ catkin_make
$ cd devel
$ ../src/scripts/pick_objects.sh  # run pick_objects node (give location updates to robot to autonomously move)
```

```bash
$ cd catkin_ws
$ catkin_make
$ cd devel
$ ../src/scripts/add_marker.sh # run add_marker node (deprecated as it is now dependent on pick_objects)
```

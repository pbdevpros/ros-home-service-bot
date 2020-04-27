## ros-rtab-mapper

### Overview

Home service robot that can autonomously guide itself around a room, in a simulated environment.

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

### Building Packages
```bash
$ cd catkin_ws
$ catkin_make
$ ./src/scripts/test_slam.sh <homeDirectory> # Input argument is optional - should be a path to the catkin\_ws folder
```



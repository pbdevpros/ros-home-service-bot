## ros-rtab-mapper

### Overview

Use RTAB map to generate 2D occupancy grid map and 3D octomap from simluation with Gazebo.

### Setup for Packages
```bash
$ mkdir catkin_ws
$ cd catkin_ws
$ git clone <project> src
$ cd src
$ catkin_init_workspace
```

### Building Packages
```bash
$ cd catkin_ws
$ catkin_make
$ source devel/setup.bash
$ roslaunch ros_robot world.launch # launches gazebo and Rvitz enviroment
```

To launch the RTAB Map node, open a separate terminal
```bash
$ source devel/setup.bash
$ cd src
$ roslaunch ros_robot mapping.launch # launch rtab map node
```

To launch user control of robot, open a separate terminal
```bash
$ source devel/setup.bash
$ cd src
$ rosrun teleop_twist_keyboard teleop_twist_keyboard.py # launch teleop keyboard control for robot
```

### Database Generation
Default location for storing data created by RTAB map package is : ```~/.ros/```. In order to view:

Open a separate terminal
```bash
$ source devel/setup.bash
$ cd src
$ rtabmap-databaseViewer ~/.ros/rtabmap.db # launch amcl localization node
```
Hit Yes to using database parameters.
Open Constraints View
Open Graph View

A link to a Google Drive folder, with the database generated from mapping the environment, in the GitHub description.

### Using Generated Database
By default, the database is deleted upon launching ROS again. In order to use the previous ```rtabmap.db```, a different launch file needs to be used, when launching RTAB Map package.

Instead of using ```mapping.launch``` as above, open a terminal and use:
```bash
$ source devel/setup.bash
$ cd src
$ roslaunch ros_robot localization.launch # launch previous db
```



#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
//#include <chrono>
//#include <thread>

// Define a client for to send goal requests to the move_base server through a SimpleActionClient
typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

int main(int argc, char** argv){
  // Initialize the simple_navigation_goals node
  ros::init(argc, argv, "pick_objects");

  //tell the action client that we want to spin a thread by default
  MoveBaseClient ac("move_base", true);

  // set up parameter to track the robots state
  ros::NodeHandle nh;
  nh.setParam("/isInPickupLocation", false);
  nh.setParam("/isInDropOffLocation", false);

  // Wait 5 sec for move_base action server to come up
  while(!ac.waitForServer(ros::Duration(5.0))){
    ROS_INFO("Waiting for the move_base action server to come up");
  }

  move_base_msgs::MoveBaseGoal goal;
  double goal_init_x =  -5.5653;
  double goal_init_y = -1.7143;
  double goal_init_w = 1.0;
  
  double goal_final_x = -1.8893;
  double goal_final_y = -5.613;
  double goal_final_w = 1.0;

  // set up the frame parameters
  goal.target_pose.header.frame_id = "map";
  goal.target_pose.header.stamp = ros::Time::now();

  // Define a position and orientation for the robot to reach
  goal.target_pose.pose.position.x = goal_init_x;
  goal.target_pose.pose.position.y = goal_init_y;
  goal.target_pose.pose.orientation.w = goal_init_w;

   // Send the goal position and orientation for the robot to reach
  ROS_INFO("Sending goal 1");
  ac.sendGoal(goal);

  // Wait an infinite time for the results
  ac.waitForResult();

  // Check if the robot reached its goal
  if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    ROS_INFO("Hooray, home service robot reached the pickup location.");
  else
    ROS_INFO("Failed to find the pickup location...");

  // set a parameter to inform that the robot has reached the pickup location
  nh.setParam("/isInPickupLocation", true);

  // Define a position and orientation for the robot to reach
  goal.target_pose.pose.position.x = goal_final_x;
  goal.target_pose.pose.position.y = goal_final_y;
  goal.target_pose.pose.orientation.w = goal_final_w;

   // Send the goal position and orientation for the robot to reach
  ROS_INFO("Sending goal 2");
  ac.sendGoal(goal);

  // Wait an infinite time for the results
  ac.waitForResult();

  // Check if the robot reached its goal
  if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    ROS_INFO("Hooray, the base moved 2 meter forward");
  else
    ROS_INFO("The base failed to move forward 2 meter for some reason");

  // alert that the location has been reached
  nh.setParam("/isInDropOffLocation", true);


  return 0;
}

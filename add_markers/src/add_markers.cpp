#include <ros/ros.h>
#include <visualization_msgs/Marker.h>

bool isInLocation; 	// global flag 
double x;
double y;
double x_initial = -5.5653; // pickup x goal
double y_initial = -1.7143; // pickup y goal
double x_final = -1.8893;	// dropoff x goal
double y_final = -5.613;	// dropoff y goal

int main( int argc, char** argv )
{
  ros::init(argc, argv, "add_markers");
  ros::NodeHandle n;
  ros::Rate r(1);
  ros::Publisher marker_pub = n.advertise<visualization_msgs::Marker>("visualization_marker", 1);
  
  // setup subscriber node
  isInLocation = false;

  // set up parameter
  ros::NodeHandle nh("/pick_objects");
  bool isParam = false;
  if (nh.hasParam("/isInPickupLocation") && nh.hasParam("/isInDropOffLocation")) {
    ROS_INFO("Found state flags for pick_objects node.");
    nh.getParam("/isInPickupLocation", isParam);
  }

  // Set our initial shape type to be a cube
  uint32_t shape = visualization_msgs::Marker::CUBE;

  visualization_msgs::Marker marker;
  // Set the frame ID and timestamp.  See the TF tutorials for information on these.
  marker.header.frame_id = "map";
  marker.header.stamp = ros::Time::now();

  // Set the namespace and id for this marker.  This serves to create a unique ID
  // Any marker sent with the same namespace and id will overwrite the old one
  marker.ns = "add_markers";
  marker.id = 0;

  // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
  marker.type = shape;

  // Set the marker action.  Options are ADD, DELETE, and new in ROS Indigo: 3 (DELETEALL)
  marker.action = visualization_msgs::Marker::ADD;

  // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
  x = x_initial;
  y = y_initial;
  marker.pose.position.x = x;
  marker.pose.position.y = y;
  marker.pose.position.z = 0.1;
  marker.pose.orientation.x = 0.0;
  marker.pose.orientation.y = 0.0;
  marker.pose.orientation.z = 0.0;
  marker.pose.orientation.w = 1.0;

  // Set the scale of the marker -- 1x1x1 here means 1m on a side
  marker.scale.x = 0.1;
  marker.scale.y = 0.1;
  marker.scale.z = 0.1;

  // Set the color -- be sure to set alpha to something non-zero!
  marker.color.r = 0.0f;
  marker.color.g = 1.0f;
  marker.color.b = 0.0f;
  marker.color.a = 1.0;

  marker.lifetime = ros::Duration();

  // Publish the marker
  while (marker_pub.getNumSubscribers() < 1)
  {
    if (!ros::ok())
    {
      return 0;
    }
    ROS_WARN_ONCE("Please create a subscriber to the marker");
    sleep(1);
  }
  marker_pub.publish(marker);

  // wait until at location
  while (!isInLocation) { 
    nh.getParam("/isInPickupLocation", isParam);
    isInLocation = isParam;    
    r.sleep();
  }
  sleep(5);
  x = x_final;
  y = y_final;
  isInLocation = false;
  isParam = false;
  
  // hide the marker and sleep for 5 seconds
  marker.action = visualization_msgs::Marker::DELETE;
  marker_pub.publish(marker);
  ROS_INFO("Hiding the marker for 5 seconds...");
  sleep(5);

  // publish the marker at the drop off zone
  marker.action = visualization_msgs::Marker::ADD;
  marker.pose.position.x = x;
  marker.pose.position.y = y;
  marker_pub.publish(marker);
  ROS_INFO("Marker is at drop off zone!");
  
  // wait until at location
  while (!isInLocation) {
    nh.getParam("/isInDropOffLocation", isParam);
    isInLocation = isParam;    
    r.sleep();
  }

  return 0;
}

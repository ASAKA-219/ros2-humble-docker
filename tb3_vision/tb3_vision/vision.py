#!/usr/bin/env python3
import rclpy
import cv2
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
def main():
    
    bridge = CvBridge()
    rclpy.init()
    node = Node("mayu_new_node")
    img = cv2.imread("/home/asakayusuke/image/mayu.jpeg")
    cv_image = bridge.cv2_to_imgmsg(img, encoding="bgr8")
    img_pub = node.create_publisher(Image, "/image", 10)
    img_pub.publish(cv_image)
    cv2.imshow("mme",img)
    cv2.waitKey(0)
    rclpy.spin(node)
    rclpy.shutdown()
if __name__ == "__main__":
    main()

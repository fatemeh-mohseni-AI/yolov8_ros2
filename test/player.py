import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2

class VideoPublisher(Node):
    def __init__(self):
        super().__init__('video_publisher')
        self.publisher_ = self.create_publisher(Image, '/robo_camera_down/rgb/image_raw', 10)
        self.timer = self.create_timer(1.0, self.publish_frame)
        self.cv_bridge = CvBridge()

    def publish_frame(self):
        cap = cv2.VideoCapture('/root/ros2_ws/src/Ros2_Yolov8/test/video.mp4') # Change the path accordingly
        if not cap.isOpened():
            self.get_logger().error("Error opening video file")
            return

        ret, frame = cap.read()
        if ret:
            img_msg = self.cv_bridge.cv2_to_imgmsg(frame, encoding="bgr8")
            self.publisher_.publish(img_msg)
        else:
            cap.release()
            cap.open('/root/ros2_ws/src/Ros2_Yolov8/test/video.mp4') # Change the path accordingly

def main(args=None):
    rclpy.init(args=args)
    video_publisher = VideoPublisher()
    rclpy.spin(video_publisher)
    video_publisher.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

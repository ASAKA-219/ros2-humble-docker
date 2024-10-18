#!/usr/bin/env python3
import cv2
import rclpy
import time
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

class face_cascade(Node):
    def __init__(self):
    	super().__init__("mayu_image_node")
    	self.img_pub = self.create_publisher(Image, "image", 10)
    	self.img_sub = self.create_subscription(Image, "image", self.callback, 10) #画像のトピックを受け取るノード
    	self.cv_bridge = CvBridge()
    	self.image_send()

    def image_send(self):
	    image = cv2.cvtColor(cv2.imread("/home/asakayusuke/image/mayu.jpeg"),cv2.COLOR_BGR2RGB) #1079,736,3
	    self.img_pub.publish(self.cv_bridge.cv2_to_imgmsg(image, encoding="bgr8"))

    def callback(self, img): #受け取った画像の処理
        # ROSの画像メッセージをOpenCVで使える形式に変換する
        image = self.cv_bridge.imgmsg_to_cv2(img, 'bgr8')

        # 画像の幅と高さを取得
        height, width = image.shape[:2] #xは縦、yは横

        # 16:9のアスペクト比を計算
        new_width = int((16 / 9) * height)

        # 中央から切り抜く範囲を計算
        x1 = 0
        x2 = width
        y1 = 100
        y2 = int(x2*9/16) + y1

        # 切り抜き
        cropped_image = image[y1:y2, x1:x2]

        # Cascade分類器によって笑顔の検出
        face_cascade = cv2.CascadeClassifier("/home/asakayusuke/opencv/data/haarcascades/haarcascade_smile.xml")

        # 検出する
        cr_img = cv2.cvtColor(cropped_image,cv2.COLOR_BGR2RGB)
        faces = face_cascade.detectMultiScale(cr_img, scaleFactor=1.25, minNeighbors=5, minSize=(30, 30))

        # 矩形を画像に描画する
        for x, y, w, h in faces:
            cv2.rectangle(cr_img, (x, y), (x + w, y + h), color=(0, 255, 0), thickness=2)

        # 画像の表示
        cv2.imshow("Mayu_new_image", cr_img)

        # 画像の保存
        #cv2.imwrite("cropped.jpg",cv2.cvtColor(cropped_image,cv2.COLOR_BGR2RGB))

        cv2.waitKey(0) # 表示する時間

def main():
    try:
        rclpy.init()
        node = face_cascade()
        rclpy.spin(node)
        rclpy.shutdown()
    except KeyboardInterrupt:
        cv2.destroyAllWindows() #画像のタブの表示終了
        pass

if __name__ == "__main__" :
    main()

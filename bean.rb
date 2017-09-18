#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default)

include OpenCV

image_src = File.expand_path('images/coins_01.jpg', File.dirname(__FILE__))

image = IplImage.load image_src

image_gray = image.BGR2GRAY

original_window = GUI::Window.new "source"
grey_window = GUI::Window.new "circles"


# grey_window.show image_grey

result = image.clone

# http://www.rubydoc.info/github/gonzedge/ruby-opencv/OpenCV/CvMat:hough_circles
detect = image_gray.hough_circles(CV_HOUGH_GRADIENT, image_gray.rows/8, 120, 1, 1)

detect.each do |circle|
  puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
  result.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
end

original_window.show image_gray
grey_window.show result

GUI::wait_key

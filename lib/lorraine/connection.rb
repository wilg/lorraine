module Lorraine
  
  class Connection
    
    require "serialport"
    
    attr_accessor :port
    
    def initialize(port = "/dev/ttyUSB0")
      
      #simplest ruby program to read from arduino serial, 
      #using the SerialPort gem
      #(http://rubygems.org/gems/serialport)


      #params for serial port
      port_str = port  # may be different for you
      baud_rate = 115200
      # data_bits = 8
      # stop_bits = 1
      # parity = SerialPort::NONE

      self.port = SerialPort.new port_str, baud_rate#, data_bits, stop_bits, parity
      
    end
    
    def write_binary_string(binary_string)
      self.port.write binary_string
    end
    
    def write_message(msg)
      puts "Writing message: #{msg}"
      write_binary_string msg.to_binary
    end
    
    def display_pixels(pixel_array)
      commands = []
      pixel_array.each_with_index do |pixel, i|
        commands << Lorraine::Message.new(:display_pixel, i, pixel[0], pixel[1], pixel[2])
      end
      commands.each do |command|
        self.write_message command
        #self.read_line
      end
    end
    
    def display_image(img)
      @current_image = img
      display_pixels img.rgb_pixels(4095)
    end
    
    def animate_to_image(other_image, duration = 1, fps = 24)
      frame_time = duration.to_f / fps.to_f
      frame_count = duration * fps
      frames = Lorraine::Image.frames_between(@current_image, other_image, frame_count)
      frames.each do |frame|
        display_image frame
        sleep frame_time
      end
    end
    
    def read_line
      m = self.port.gets
      puts "Lorraine::Connection Message: #{m}"
      m
    end
    
    def sever!
      self.port.close # see note 1
    end
    
  end
  
end

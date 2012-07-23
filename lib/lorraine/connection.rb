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
        self.read_line
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

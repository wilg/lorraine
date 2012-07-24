module Lorraine
  
  class SerialConnection < Lorraine::Connection
    
    require "serialport"
    
    attr_accessor :port
    
    def initialize
      super
      
      #simplest ruby program to read from arduino serial, 
      #using the SerialPort gem
      #(http://rubygems.org/gems/serialport)


      #params for serial port
      # port_str = port  # may be different for you
      baud_rate = 115200
      # data_bits = 8
      # stop_bits = 1
      # parity = SerialPort::NONE

      self.port = SerialPort.new Lorraine::SerialConnection.first_available_port, baud_rate#, data_bits, stop_bits, parity
      
    end
    
    def self.first_available_port
      p = Dir.glob("/dev/tty.usb*").first
      raise "No available ports." unless p
      p
    end
    
    def write_binary_string(binary_string)
      self.port.write binary_string
    end
    
    def write_message(msg)
      puts "Writing serial message: #{msg}"
      write_binary_string msg.to_binary
    end
    
    def read_line
      m = self.port.gets
      puts "Lorraine::SerialConnection Message: #{m}"
      m
    end
    
    def sever!
      super
      self.port.close
    end
    
  end
  
end

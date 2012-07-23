module Lorraine
  
  class Command
    
    def self.run(command, args)
      # puts "command: #{command}"
      # puts "   args: #{args}"
      # puts "Starting connection... with serialort #{SerialPort::VERSION}"
      
      # Lorraine::Connection.new
      # c = Lorraine::Message.new :display_pixel, 2, 0, 0, 4095
      # puts "command: #{c}"
      # puts "binary: #{c.to_binary}"
      # puts "back in: #{Lorraine::Message.decode c.to_binary}"
      
      connection = Lorraine::Connection.new "/dev/tty.usbserial-A100A9J6"
      puts "Waiting 5 seconds..."
      sleep 5
      puts "Writing..."
      # connection.write_message c
      connection.display_pixels [[4096, 0, 0], [0, 4096, 0], [0, 0, 4096]]
      
      # while true
      #   puts "readline: #{connection.port.gets}"
      #   # printf("%c", connection.port.getc)
      # end
      connection.sever!
      
    end
    
  end
  
end
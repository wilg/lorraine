module Lorraine
  
  class Command
    
    def self.run(command, args)
      puts "command: #{command}"
      puts "   args: #{args}"
      puts "Starting connection... with serialort #{SerialPort::VERSION}"
      
      # Lorraine::Connection.new
      c = Lorraine::Message.new :display_frame, 0, 512, 5312, 512
      # puts "command: #{c}"
      # puts "binary: #{c.to_binary}"
      puts "back in: #{Lorraine::Message.decode c.to_binary}"
      
      connection = Lorraine::Connection.new "/dev/tty.usbserial-A100A9J6"
      sleep 5
      puts "Done sleeping..."
      connection.write_message c
      while true
        puts "readline: #{connection.port.gets}"
        # printf("%c", connection.port.getc)
      end
      connection.sever!
      
    end
    
  end
  
end
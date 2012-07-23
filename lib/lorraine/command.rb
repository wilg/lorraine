module Lorraine
  
  class Command
    
    def self.run(command, args)
      puts "command: #{command}"
      puts "   args: #{args}"
      puts "Starting connection..."
      
      # Lorraine::Connection.new
      c = Lorraine::Message.new :display_frame, 0, 512, 5312, 512
      # puts "command: #{c}"
      # puts "binary: #{c.to_binary}"
      # puts "back in: #{Lorraine::Message.decode c.to_binary}"
      
      connection = Lorraine::Connection.new
      while true
        connection.write_message c
        connection.read
      end
      connection.sever!
      
    end
    
  end
  
end
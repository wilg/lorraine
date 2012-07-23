module Lorraine
  
  class FakeConnection < Connection
        
    def initialize(port = nil)
      nil
    end

    def write_message(msg)
      puts "Writing message: #{msg}"
      write_binary_string msg.to_binary
    end
    
    def sever!
      nil
    end
    
  end
  
end

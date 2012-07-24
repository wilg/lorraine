module Lorraine
  
  class NetworkConnection < Lorraine::Connection
    
    attr_writer :hostname
    def hostname
      @hostname || "localhost"
    end
    
    attr_writer :port
    def port
      @port || "3010"
    end
        
    def write_message(msg)
      Lorraine::Client.send_message(msg, self.hostname, self.port)
      puts "Writing network message: #{msg}"
    end

  end
  
end

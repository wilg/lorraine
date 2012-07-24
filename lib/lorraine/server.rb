module Lorraine
  
  class Server
    
    require 'faye'
    require 'thin'
    
    def self.start(port)
      serial_connection = Lorraine::Connection.new      
      Thin::Server.start('0.0.0.0', port) do
        Faye::WebSocket.load_adapter('thin')
        faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
        faye_server.bind(:publish) do |client_id, channel, data|
          # Process incoming things
          m = Lorraine::Message.from_packet(data)
          puts "Received message: #{m}"
          serial_connection.write_message(m)
        end
        run faye_server
      end
    end
          
  end
  
  class Client
    
    require 'json'
    require 'httpclient'
    
    def self.send_message(message, address = "localhost", port = "1964")
      
      faye_json = {channel: "/illuminate", data: message.packet}.to_json
     
      client = HTTPClient.new
      puts client.post("http://#{address}:#{port}/faye", {message: faye_json})

    end
    
  end
  
end

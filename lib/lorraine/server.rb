module Lorraine
  
  class Server
    
    require 'faye'
    require 'thin'
    
    def self.start(port)
      begin
        serial_connection = Lorraine::SerialConnection.new      
      rescue
        "Failed to start serial connection."
      end
      Thin::Server.start('0.0.0.0', port) do
        
        map "/admin" do
          files = File.expand_path(File.join(__FILE__, "..", "..", "..", "web"))
          puts "serving files from #{files}"
          run Rack::File.new(files)
        end
        
        Faye::WebSocket.load_adapter('thin')
        faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
        faye_server.bind(:publish) do |client_id, channel, data|
          begin
            # Process incoming things
            puts "Received message data: #{data}"
            m = Lorraine::Message.from_packet(data)
            puts "Interpereted as: #{m}"
            serial_connection.write_message(m)
            # serial_connection.write_message Lorraine::Message.new(:refresh)
          rescue
            puts "Failed to read data."
          end
        end
        run faye_server
      end
    end
          
  end
  
  class Client
    
    require 'json'
    require 'httpclient'
    
    def self.send_message(message, address = "localhost", port = "3010")
      
      faye_json = {channel: "/illuminate", data: message.packet}.to_json
      
      puts "sending json: #{faye_json}"
     
      client = HTTPClient.new
      puts client.post("http://#{address}:#{port}/faye", {message: faye_json})

    end
    
  end
  
end

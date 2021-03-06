module Lorraine
  
  class Message
    
    require 'json'
    
    # Command ID   - 16 bit unsigned integer (S)
    # Address      - 16 bit unsigned integer (S)
    # Red value    - 16 bit unsigned integer (S)
    # Green value  - 16 bit unsigned integer (S)
    # Blue value   - 16 bit unsigned integer (S)
    
    def self.format
      "nnnnn"
    end
    
    def initialize(command = 0, pixel = 0, red = 0, green = 0, blue = 0)
      self.command = command
      self.pixel   = pixel
      self.red     = red
      self.green   = green
      self.blue    = blue
    end
    
    def self.decode(binary_string)
      m = Lorraine::Message.new
      m.command_id, m.pixel, m.red, m.green, m.blue = binary_string.unpack(Lorraine::Message.format)
      m
    end
        
    attr_accessor :red
    attr_accessor :green
    attr_accessor :blue
    attr_accessor :command
    attr_accessor :pixel
    
    COMMAND_IDS = {set_pixel: 1, refresh: 2, effect: 3}
    
    def command_id
      COMMAND_IDS[self.command]
    end
    
    def command_id=(id)
      self.command = COMMAND_IDS.invert[id]
    end
    
    def packet
      [self.command_id, self.pixel.to_i, self.red.to_i, self.green.to_i, self.blue.to_i]
    end
    
    def packet=(new_packet)
      self.command_id, self.pixel, self.red, self.green, self.blue = new_packet
    end
    
    def self.from_json(json)
      Lorraine::Message.from_packet JSON.parse(json)
    end
    
    def self.from_packet(p)
      m = Lorraine::Message.new
      m.packet = p
      m
    end
    
    def to_json
      self.packet.to_json
    end
    
    def to_binary
      self.packet.pack(Lorraine::Message.format)
    end
    
    def to_s
      "#<Lorraine::Message command=#{command} pixel=#{pixel} r=#{red} g=#{green} b=#{blue} bytes=#{to_binary.length}>"
    end
    
  end
  
end
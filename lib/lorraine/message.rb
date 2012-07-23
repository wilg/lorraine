module Lorraine
  
  class Message
    
    # Command ID   - 16 bit unsigned integer (S)
    # Address      - 16 bit unsigned integer (S)
    # Red value    - 16 bit unsigned integer (S)
    # Green value  - 16 bit unsigned integer (S)
    # Blue value   - 16 bit unsigned integer (S)
    
    def self.format
      "nnnnn"
    end
    
    def initialize(command = nil, pixel = nil, red = nil, green = nil, blue = nil)
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
    
    COMMAND_IDS = {display_pixel: 1}
    
    def command_id
      COMMAND_IDS[self.command]
    end
    
    def command_id=(id)
      self.command = COMMAND_IDS.invert[id]
    end
    
    def to_binary
      packet = [self.command_id, self.pixel, self.red, self.green, self.blue]
      packet.pack(Lorraine::Message.format)
    end
    
    def to_s
      "#<Lorraine::Message command=#{command} pixel=#{pixel} r=#{red} g=#{green} b=#{blue} bytes=#{to_binary.length}>"
    end
    
  end
  
end


AdventPos = Struct.new(:layer, :x, :y, :mx, :my)

class AdventMap
  attr_reader :adv_pos
  
  def initialize(adv_pos)
    @adv_pos = adv_pos.map do|n|
      [n[3], n[4], n[1], n[2], layer_to_z_index(n[0])]
    end
  end
  
  def get_random
    @adv_pos[rand(@adv_pos.size)]
  end
  
  def layer_to_z_index(layer)
    case layer
    when 1; 1
    when 2; 3
    else; raise "invalid Character layer"
    end
  end
end











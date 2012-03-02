#coding:windows-31j

class StageSample2 < StageBase
  def setup
    super
    add_item Picture.new('bg3.png')
    
    back = Picture.new('back.png',0,0,2)
    add_item back
    add_item Picture.new('front.png',0,0,4)
    
    
  end
  
  def stage_name; "夜" end
  
  def play
    super
    
    if @move_items.size < 14 &&
      n = rand 
      if n < 0.01
        add_item Tono.new(self, *@advent_map.get_random) 
      elsif n < 0.05
        add_item Alien.new(self, *@advent_map.get_random)
      end
    end
    
  end
  
  def stage_exit
    self.stage_end
    Scene.set_current_scene :ending
  end
end
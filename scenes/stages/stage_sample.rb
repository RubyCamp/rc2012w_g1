#coding:windows-31j

class StageSample < StageBase
  def setup
    super
    add_item Picture.new('bg2.png')
    
    back = Picture.new('back.png',0,0,2)
    add_item back
    add_item Picture.new('front.png',0,0,4)
    
    
  end
  
  def stage_name; "夕暮れ" end
  
  def play
    super
    
    if @move_items.size < 10 && rand < 0.04
      add_item Alien.new(self, *@advent_map.get_random)
    end
    
  end
  
  def stage_exit
    self.stage_end
    Scene.set_current_scene :stage_sample_2
  end
end
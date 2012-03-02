#coding:windows-31j

make_require = lambda do|dir|
  lambda do|*files|
    files.each do|n|
      require_relative File.join(dir, n)
    end
  end
end

make_require['characters'][
  'picture',
  'character',
  'simplemove',
  'bullet',
  'tono',
  'alien',
  'advent_map'
]
make_require['etc'][
  'countdown',
  'positioncsv'
]

make_require['effects'][
  'effect_base',
  'bomb_effect',
  'crash_effect',
  'rotation_effect'
]




class StageBase
  @@char_position = PositionCSV.load
  
  @@sound = lambda{
    s = Resources.sound("battle.wav")
    s.loopCount = -1
    s
  }.call
  
  attr_accessor :score
  
  attr_reader :draw_items, :collision_items
  
  LimitTime = 30#60
  LimitTimeFont = {size:22}
  
  
  def setup
    #puts  "#{self.class} == #{StageBase}   #{self.class == StageBase}"
    return if self.class == StageBase
    @score = 0
    @move_items = []
    @draw_items = []
    @collision_items = []
    @limit_time = LimitTime
    @countdown  = nil; 
    @font = Font.new(
      LimitTimeFont[:size] || 24,
      LimitTimeFont[:name] || Resources::Font::Name,
      LimitTimeFont[:opt]  || {}
    )
    
    @bullet = Bullet.new(self)
    self.add_item(@bullet, [:collision])
    @@sound.play
  end
  
  def countdown; @countdown ||= Countdown.new( @limit_time ) end
  
  def stage_fail
    Scene.set_current_scene(:gameover)
  end
  
  def play
    self.stage_exit unless countdown.timecount? 
    
    @move_items.each{|n| n.move}
    @bullet.make(Input.mousePosX, Input.mousePosY) if Input.mousePush?(M_LBUTTON)
    
    check_collision
    
    draw
  end
  
  def draw
    @draw_items.each do|n|
      n.each{|j| j.draw} if n
      #sleep(0.6)
    end
    draw_stage_info
  end
  
  def add_item(item, exclude = [])
    @move_items          << item if item.respond_to?(:move)      && !exclude.include?(:move) 
    if item.respond_to?(:draw ) && !exclude.include?(:draw)
      @draw_items[item.z] = [] unless @draw_items[item.z]
      @draw_items[item.z] << item
    end
    @collision_items     << item if item.respond_to?(:collision) && !exclude.include?(:collision)
  end
  
  def delete_item(item)
    @move_items.delete(item)      if item.respond_to?(:move)
    @draw_items[item.z].delete(item)    if item.respond_to?(:draw )
    @collision_items.delete(item) if item.respond_to?(:collision)
  end
  
  def stage_end
    Scene.common.score += @score;
    @@sound.stop
  end
  
  def gameover
    self.stage_end
    Scene.set_current_scene(:ending)
  end
  
  private
  
  def check_collision
    Collision.check([@bullet.collision], @collision_items.map(&:collision))
  end
  
  def stage_name; "unnamed_stage" end
  
  
  FontColor         = [0,0,0]
  
  def draw_stage_info
    Window.drawFont(
        Window.width - @font.getWidth(self.stage_name), Window.height - @font.size,
        stage_name, @font, color:FontColor )
    str = "残り時間 #{countdown.now.to_i}秒"
    Window.drawFont(
        Window.width - @font.getWidth(str), Window.height - @font.size*2,
        str, @font, color:FontColor )
    str2 = "得点 #{@score}"    
    Window.drawFont(
        Window.width - @font.getWidth(str2), Window.height - @font.size*3,
        str2, @font, color:FontColor )
  end
end





class StageBase
  alias old_setup setup
  def setup
    old_setup
    @advent_map = AdventMap.new(@@char_position)
  end
end
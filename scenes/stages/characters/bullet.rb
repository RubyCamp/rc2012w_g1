#coding:utf-8
require_relative 'character'

class Bullet < Character
  
  CntUp = 1.0 / 20
  #HitCheckFrame = 6
  
  attr_reader :active, :speed
  
  def center_x; @x - @image.width/ 2 end
  def center_y; @y - @image.height / 2 end
  
  @@sound_shot = Resources.sound('click.wav')
  @@sound_bomb = Resources.sound('bomb.wav')
  
  ZIndex = 5
  
  def initialize(director,*args)
    super(director,*args)
    @speed = speed
    @scale = 0
    @collision = CollisionPoint.new(self)
    self.collision_active = false
    @active = false
    @z = ZIndex
  end
  
  def make(x,y)
    unless @active
      @x = x; @y = y
      @scale = 0
      self.collision_active = false
      @active = true; @dispose_cnt = nil
      @@sound_shot.play
    end
  end
  
  def dispose
    @active = false
    self.collision_active = false
  end
  
  def move
    if @active
      if @scale < 1.0
        @scale += CntUp
      elsif ! self.collision_active
        self.collision_active = true
        @dispose_cnt = 0
      else
        @@sound_bomb.play
        @director.add_item BombEffect.new(@director, @x-16, @y-16, @z)
        self.dispose
      end
    end
    if collision_active
      self.collision.set(@x, @y)
    else
      self.collision.delete
    end
  end
  
  def draw
    if @active
      Window.drawScale(center_x(), center_y() ,@image,1.0-@scale,1.0-@scale)
      #Window.drawScale(@x ,@y ,@image,1.0-@scale,1.0-@scale)
    end
  end
  
  def char_image(image_file = nil)
    Image.load File.join(File.dirname(__FILE__), "..", "images", 'bomb.png')
  end
  
  def shot(obj)
  
    puts obj
    obj.crash
  end
end



if __FILE__ ==  $PROGRAM_NAME
  require 'dxruby'
  require 'dxrubyex'
  require_relative 'player'
  require_relative 'enemy'
  
  module Window
    class<<self
      alias oldDrawFont drawFont 
      def drawFont(x,y,str,font,opt = {})
        oldDrawFont(x,y,str.encode('shift_jis'),font,opt)
      end
    end
  end

  def draw_items
    @draw_items ||= [@bullet] + @enemies
  end
  
  class Enemy
    def crash
      puts "ENEMY"
    end
  end
  
  class E2 < Character
    def move
      @x += 2; @y += 4
      @x = 0 unless @x < Window.width
      @y = 0 unless @y < Window.height
      super
    end
    
    def crash
      Window.drawFont(0,0,"ほげほげ",Font.new(16))
      puts "hoge crash"
    end
    
    def char_image(image_file = nil)
      Image.new(60,60,[255,255,0])
    end
  end
  
  
  def check_collision
    Collision.check([@bullet.collision], @enemies.map(&:collision))
  end
  
  @bullet = Bullet.new(self,)
  @enemies = []
  @enemies << Enemy.new(self, 250, 170) << E2.new(self) << E2.new(self,32,0)
  
  Window.loop do
    @bullet.make(Input.mousePosX,Input.mousePosY) if Input.mousePush?(M_LBUTTON) && !@bullet.active
    
    draw_items.each do|n|
      n.move
      n.draw
    end
    
    check_collision
  end
end






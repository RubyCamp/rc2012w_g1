
require_relative 'simple_move_moge'
class Tono < Character
  include SimpleMove#Moge
  
  @@sound = Resources.sound( "pon.wav" )
  
  Speed = 3
  def initialize(director, mx, my,  x = 400, y = 550, z = 0)
    super(director, x, y, z, nil)
    @mx = mx
    @my = my
    @speed = Speed
    @mvstt = :hide
  end


  def char_image(image_file )
    @@image ||= Image.load(File.join(File.dirname(__FILE__), "..", "images", "tonosama.png"))
  end
  
  def crash
    #puts "#{@collision}"
    @@sound.play
    @director.add_item  RotationEffect.new(@director, @x, @y,@z, @mx, image_file:'burnedtonosama.png')
    @director.gameover
  end
end

#def crash
#    #自分を消して　png
#    
#    #点数加算 @score
#    p @director
#    
#    #effect呼び込む 
#    #
#  end
#end


##ここを追加すればサンプルコードが動くよ
#class Player
#  def move
#    dx = Input.x * 2
#    dy = Input.y * 2
#    @x += dx if valid_x_range?(dx)
#    @y += dy if valid_y_range?(dy)
#    super
#  end
#end
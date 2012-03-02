class Alien < Character
  include SimpleMove

  Speed = 5
  def initialize(director, mx, my,  x = 400, y = 550, z = 0)
    super(director, x, y, z, nil)
    @mx = mx
    @my = my
    @speed = Speed
    @mvstt = :hide
  end


  def char_image(image_file)
    @@image = Image.load( File.join(File.dirname(__FILE__), "..", "images", "alien.png") )
  end

  def draw
    Window.draw(@x, @y, @image)
  end

#  def hit
#  end

  def crash
    puts "#{@image.object_id}"
    rotation_effect = RotationEffect.new(@director, @x, @y, @z, @mx)
    @director.add_item rotation_effect
    @director.delete_item self
    @director.score += 142
  end
end


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
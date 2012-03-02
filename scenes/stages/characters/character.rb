class Character
  attr_accessor :collision, :x, :y, :collision_active, :z

  def center_x; @x - @image.width / 2 end
  def center_y; @y - @image.height / 2 end

  def initialize(director, x = 400, y = 550, z = 0, image_file = nil)
    @director = director
    @x = x; @y = y; @z = z
    @image = char_image(image_file)
    @collision = CollisionCircle.new(self, @image.width/ 2, @image.height/ 2,@image.width / 2)
    @collision_active = true
    #puts "#@x #@y #@z"
  end

  def move
    if collision_active
      self.collision.set(@x, @y)
    else
      self.collision.delete
    end
  end

  def draw
    Window.draw(@x,  @y, @image)
  end

  private

  def reset_collision_pos
    self.collision.set(@x, @y)
  end

  def valid_x_range?(dx)
    !((@x + dx + @image.width) > Window.width || (@x + dx) < 0)
  end

  def valid_y_range?(dy)
    !((@y + dy + @image.height) > Window.height || (@y + dy) < 0)
  end
end


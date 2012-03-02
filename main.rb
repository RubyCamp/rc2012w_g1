require_relative 'u_game'
require_relative 'o_game'

require_relative File.join 'lib', 'font', 'font'

def Scene.make_common
  o = OpenStruct.new
  o.score = 0
  o
end

Ugame.load_scenes
Ugame.init_window(800, 600, "RubyCamp2010 Example")

Ogame.make_stages


Scene.set_current_scene(:title)


Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  Scene.play_scene
end


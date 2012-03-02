require 'ostruct'

class Scene
  def self.scenes; @@scenes end
  
  class<<self
    def common; @common ||= make_common() end
  end

  @@scenes = {}

  @@current_scene_name = nil

  def self.add_scene(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  def self.set_current_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
    @@scenes[@@current_scene_name].setup if @@scenes[@@current_scene_name].respond_to?(:setup)
  end

  def self.play_scene
    @@scenes[@@current_scene_name].play
  end
end

class Scene
  def self.exit
    @@scenes = nil
  end

  def self.empty?
    @@scenes.nil?
  end
end



module Ogame
  module_function
  
  StageDir = File.join(File.dirname(__FILE__), 'scenes', 'stages')
  
  
  def make_stages(scene_opts = {})
    base_path = StageDir
    Dir.foreach(base_path) do |item|
      next if item == '.' || item == '..' || File.directory?(File.join(base_path, item))

      file = File.join(base_path, item)
      
      if File.exist?(file)
        base_name  = File.basename(file, ".*")

        if base_name =~ /\Astage.+\z/
          require file
          class_name = base_name.split("_").map{|part| part.downcase.capitalize}.join("").to_sym
  
          if scene_opts[class_name]
            scene_obj  = Object.const_get(class_name).new(scene_opts[class_name])
          else
            scene_obj  = Object.const_get(class_name).new
          end
          Scene.add_scene(scene_obj,  base_name.to_sym)
        end
      end
    end
  end
end



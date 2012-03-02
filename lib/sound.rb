

module Resources
  module_function
  SoundDir = File.join(File.dirname(__FILE__), '..' , 'sound')
    
  def sound(file)
    file = File.join(SoundDir,file)
    Sound.new(file)
  end
end

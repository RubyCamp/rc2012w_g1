#coding:windows-31j

require 'dxruby'

Font.install File.join(File.dirname(__FILE__),'KouzanGyoushoOTF.otf')

module Resources
  module Font
    Name = '衡山毛筆フォント行書 OTF'
    
    def self.kouzan_new(*args); Font.new(KouzanName,*args) end
  end
end



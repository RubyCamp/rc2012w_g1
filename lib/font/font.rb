#coding:windows-31j

require 'dxruby'

Font.install File.join(File.dirname(__FILE__),'KouzanGyoushoOTF.otf')

module Resources
  module Font
    Name = '�t�R�ѕM�t�H���g�s�� OTF'
    
    def self.kouzan_new(*args); Font.new(KouzanName,*args) end
  end
end



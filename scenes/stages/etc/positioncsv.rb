#coding:windows-31j

#./resources/appearingposition.csvにファイルを置いてください。
module PositionCSV
  module_function
  
  FileName = File.join( File.dirname(__FILE__) , 'appearingpoints.csv')
  
  def load
    @positions = []
    File.open(FileName, 'r') do |f|
      f.each do|line|
        @positions << line.split(/,/).map{|i| i.to_i}
      end
    end
    @positions
  end
end



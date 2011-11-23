
require './setting'
require './vessel'

System = Object.new
class << System

  def init
    OuterVessel.init
  end

  def evolve
    Setting.System.NumberTrial.times do
      OuterVessel.evolve
      #elements.each do |element|
        #element.evolve
      #end
    end

    output
  end

  def output
    return if OuterVessel.log.empty?
    OuterVessel.output
  end


end

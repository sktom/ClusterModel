
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
    p OuterVessel.log
    return if elements.first.log.empty?
    File.open('res', 'w') do |fout|
      enumArray = elements.map do |element|
        element.each
      end
      elements.first.log.count.times do
        fout.puts enumArray.map{|ea| ea.next}.join(' ')
      end
    end

  end


end


require './water'
require './setting'

class Vessel
  attr :water
  def inintialize
    setting = Setting.system.vessel 
    @setting =
      case self.class
      when OuterVessel
        setting.outer
      when InnerVessel
        setting.inner
      end
    @water = Water.new @setting.water.volume
    @surface = @setting.surface
  end

end

class OuterVessel < Vessel

  def initialize
    super
    @setting.number_vessel.times do
      @inner_vessels << InnerVessel.new
    end
  end

end

class InnerVessel < Vessel

  def inintialize
    super
  end

end


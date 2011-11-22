
require './element'
require './water'
require './setting'

class Vessel
  include Element
  attr :water
  def height_water
    @water.volume / @Surface
  end

  def init
    setting = Setting.System.Vessel 
    @setting =
      case self
      when OuterVessel
        setting.Outer
      when InnerVessel
        setting.Inner
      end
    @water = Water.new @setting.Water.volume
    @Surface = @setting.Surface
    @log = [height_water]
  end

  def evolve; end


end

OuterVessel = Vessel.new
class << OuterVessel

  alias general_init init
  def init
    general_init
    number_vessel = @setting.NumberVessel 
    @inner_vessels = Array.new(number_vessel).map{
      InnerVessel.new
    }
  end

  def evolve
    @inner_vessels.each do |iv|
      iv.evolve
    end
    @water.volume += @inner_vessels.map{|iv| iv.dv}.inject(:+)
    @log << height_water
  end


end

class InnerVessel < Vessel
  def dv
    @dh * @Surface
  end

  def initialize
    init
    @water = Water.new(
      @setting.Water.volume * (1 + (rand * 2 - 1) / 100))
    @dh = 0
  end

  def evolve
    dif_height = OuterVessel.height_water - height_water
    @dh += dif_height / 10000
    @water.volume += @dh * @Surface
    @log << height_water
  end


end


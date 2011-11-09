
require 'vessel'

outer_vessel = OuterVessel.new {:nuber_inner_vessel => 3}

1000.times do
  outer_vessel.evolve
end

outer_vessel.output 'result'


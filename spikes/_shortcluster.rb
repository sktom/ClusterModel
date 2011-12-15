
def h phi
  phi < Math::PI ? Math::exp() : Math::exp()
end

def h_ov_ phi
  - h(phi)
end

def g phi, h_ov
  dH = h_ov - h_ov_(phi)
  phi < Math::PI ? -dH : dH
end

omega = 10 ** -2
initial_profile = Array.new(5).map{rand(2 * Math::PI)}
inner_vessels = initial_profile
outer_vessel = - inner_vessels.map{|iv| h(iv)}.inject(:+)

100.times do
  inner_vessels.map! do |iv|
    omega + g(iv, outer_vessel)
  end
  outer_vessel = - inner_vessels.map{|iv| h iv}.inject(:+)
  puts inner_vessels.map{|iv| h iv}.unshift(outer_vessel).join(' ')
end


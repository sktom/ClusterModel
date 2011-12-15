
module Math; def self.ln x; log x, E; end; end

alpha = - Math::ln(2) / Math::PI

Kernel.send :define_method, :h do |phi|
  phi < Math::PI ? -4 * Math::exp(alpha * phi) + 3 :
    8 * Math::exp(alpha * phi) - 3
end

def h_ov_ phi
  - h(phi)
end

def g phi, h_ov
  dH = h_ov - h_ov_(phi)
  g_amp = dH * 10 ** -5
  phi < Math::PI ? g_amp : -g_amp
end

omega = 10 ** -3
initial_profile = Array.new(5).map{rand * 2 * Math::PI}
phases = initial_profile
h_ov = - phases.map{|phi| h phi}.inject(:+)

1000000.times do |i|
  puts phases.map{|phi| phi}.join(' ') if i % 100 == 0
  phases.map! do |phi|
    (phi + omega + g(phi, h_ov)) % (2 * Math::PI)
  end
  h_ov = - phases.map{|phi| h phi}.inject(:+)
  #puts phases.map{|phi| h phi}.unshift(h_ov).join(' ')
end


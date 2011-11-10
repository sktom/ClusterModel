
System = Array.new
class << System

  def evolve number_trial
    number_trial.times do
      each do |element|
        element.evolve
      end
    end

    output
  end

  def output
    return if empty?
    File.open('res', 'w') do |fout|
      enumArray = map do |element|
        element.each
      end
      first.log.count.times do
        fout.puts enumArray.map{|ea| ea.next}.join
      end
    end

  end

end

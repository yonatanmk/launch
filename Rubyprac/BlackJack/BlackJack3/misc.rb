class Mammal
  def breathe
    puts 'Breathing'
  end
end

class Human < Mammal
  def walk
    puts 'walking'
  end

  def breathe
    puts 'Breathing better'
  end
end

mammal = Mammal.new
human = Human.new

human.breathe

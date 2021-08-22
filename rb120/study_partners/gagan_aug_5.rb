# Question 1
module Candidate
  def candidacy
    puts "I am a #{BADGE} space program candidate"
  end
end

class NASA
  BADGE = "US"
end

class Astronaut < NASA
  include Candidate
end

roger = Astronaut.new
roger.candidacy # => What will be output here?

# Question 2
class Noodle
  @@primary_ingredient = "Rice"

  attr_reader :type

  def initialize(type)
    @type = "#{@@primary_ingredient} #{type}"
  end
end

class Udon < Noodle
end

class Pasta < Noodle
  @@primary_ingredient = "Wheat"
end

class GlutenFree < Noodle
  def initialize(type)
    super
    @@primary_ingredient = "Buckwheat"
  end
end

udon = Udon.new("Udon")
p udon.type
# => "Wheat Udon"

buckwheat = GlutenFree.new("Rigattoni")
p buckwheat.type # => Wheat Rigattoni

pasta = Pasta.new("Spaghetti")
p pasta.type # => "Buckwheat Spaghetti"

# --

# When does accidental method overriding occur, and why? Give an example.

class PlayNumbers
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def str
    format("%02d", num)
  end

  # def send
  #   num.to_s(2)
  # end
end

a = PlayNumbers.new(9)
b = PlayNumbers.new(11)


p a.send :str




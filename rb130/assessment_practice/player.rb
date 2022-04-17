class Player
  attr_reader :name
  attr_accessor :health

  def initialize(name, health = 50)
    @name = name.capitalize
    @health = health
  end

  def dead?
    health < 0
  end

  def to_s
    if dead?
      "I was #{name}, now I am dead :(."
    else
      "I'm #{name} with health = #{health}."
    end
  end

  def boost
    if dead?
      raise NoMethodError
    else
      self.health += 20 unless dead?
    end
  end

  def hurt
    if dead?
      raise NoMethodError
    else
      self.health -= 10 unless dead?
    end
  end
end
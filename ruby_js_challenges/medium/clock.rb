class Clock
  MINUTES_PER_HOUR = 60
  MINUTES_PER_DAY = 1440
  
  def self.at(hour, minute = 0)
    minutes = (hour * MINUTES_PER_HOUR) + minute
    Clock.new(minutes)
  end
  
  def initialize(minutes)
    @minutes = minutes
  end
  
  def to_s
    days = @minutes.divmod(MINUTES_PER_DAY)
    time = days[1].divmod(MINUTES_PER_HOUR)
    format("%02d:%02d", time[0], time[1])
  end
  
  def +(other)
    @minutes += other
    self
  end
  
  def -(other)
    @minutes -= other
    self
  end
  
  def ==(other)
    to_s == other.to_s
  end
end
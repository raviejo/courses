require 'date'

class Meetup
  DAYS = %w(sunday monday tuesday wednesday thursday friday saturday)
  DESCRIPTORS = %w(first second third fourth fifth)
  TEENTH_DAYS = (13..19).to_a
  
  def initialize(year, month)
    @year = year
    @month = month
    set_calendar
  end
  
  def set_calendar
    calendar = {}
    (1..31).each do |mday|
      if Date.valid_civil?(@year, @month, mday)
        date = Date.civil(@year, @month, mday)
        day = DAYS[date.wday]
        if calendar.include?(day)
          calendar[day] << date
        else
          calendar[day] = [date]
        end
      end
    end
    @calendar = calendar
  end
  
  def day(wday, descriptor)
    @wday = wday.downcase
    @descriptor = descriptor.downcase
    index = describe
    if index.nil?
      @calendar[@wday].select { |date| TEENTH_DAYS.include?(date.mday) }.first
    else
      @calendar[@wday][index]
    end
  end
  
  def describe
    if DESCRIPTORS.include?(@descriptor)
      DESCRIPTORS.index(@descriptor)
    elsif @descriptor == 'last'
      -1
    end
  end
end
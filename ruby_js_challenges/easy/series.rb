class Series
  def initialize(str_series)
    @str_series = str_series
  end
  
  def slices(len)
    raise ArgumentError if len > @str_series.size
    result = []
    @str_series.size.times do |idx|
      sliced = @str_series[idx, len]
      break if sliced.size < len
      placeholder = []
      sliced.each_char { |char| placeholder << char.to_i }
      result << placeholder
    end
    result
  end
end
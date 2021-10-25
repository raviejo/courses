class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other)
    distance = 0
    other_list = other.chars
    @strand.chars.each.with_index do |point, idx|
      break if other[idx].nil?
      distance += 1 if point != other_list[idx]
    end
    distance
  end
end


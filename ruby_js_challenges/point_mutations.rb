class DNA
  def initialize(strand)
    @strand = strand
  end
  
  def hamming_distance(other)
    distance = 0
    other_list = other.split
    @strand.split.each.with_index { |point, idx| distance += 1 if point != other_list[idx] }
    distance
  end
end
class CustomSet
  attr_reader :set
  
  def initialize(set = [])
    @set = set.uniq
  end
  
  def empty?
    set.empty?
  end
  
  def contains?(elt)
    set.include?(elt)
  end
  
  def subset?(other)
    empty? ? true : set.all? { |elt| other.contains?(elt) }
  end
  
  def disjoint?(other)
    set.none? { |elt| other.contains?(elt) }
  end
  
  def eql?(other)
    return false unless set.size == other.set.size
    set.all? { |elt| other.contains?(elt) }
  end
  
  def add(elt)
    set << elt unless contains?(elt)
    self
  end
  
  def intersection(other)
    intersected = CustomSet.new([])
    set.each { |elt| intersected.add(elt) if other.contains?(elt) }
    intersected
  end
  
  def difference(other)
    differ = CustomSet.new([])
    set.each { |elt| differ.add(elt) unless other.contains?(elt) }
    differ
  end
  
  def union(other)
    union_set = CustomSet.new(set)
    other.set.each { |elt| union_set.add(elt) }
    union_set
  end
  
  def ==(other)
    eql?(other)
  end
end
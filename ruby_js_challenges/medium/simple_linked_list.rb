class SimpleLinkedList
  attr_reader :head
  
  def empty?
    @head.nil?
  end
  
  def push(datum)
    empty? ? @head = Element.new(datum) : tail.next = Element.new(datum)
  end
  
  def tail
    if !empty?
      current = @head
      until current.tail? do
        current = current.next
      end
      current
    else
      @head
    end
  end
  
  def pop
    current = @head
    if !empty?
      index = size - 1
      until index.zero? do
        current = current.next
        index -= 1
      end
      popped = current.next
      current.next = nil
      
      if current.tail?
        datum = @head.datum
        @head = nil
        datum
      else
        popped.datum
      end
    else
      current
    end
  end
  
  def size
    counter = 0
    if !empty?
      counter = 1
      current = @head
      until current.tail? do
        current = current.next
        counter += 1
      end
      counter
    else
      counter
    end
  end
  
  def peek
    empty? ? nil : @head.datum
  end
  
  def self.from_a(ary)
    list = new
    ary.each do |datum|
      list.push(datum)
    end
  end
  
  def to_a
    ary = []
    current = @head
    if !empty?
      ary << current
      until current.tail? do
        ary << current
        current = current.next
      end
      current
    else
      current
    end
  end
end


class Element
  attr_reader :datum
  attr_accessor :next
  
  def initialize(datum, next_element = nil)
    @datum = datum
    @next = next_element
  end
  
  def tail?
    @next.nil?
  end
end


list = SimpleLinkedList.new
list.push(1)
puts list.pop
puts list.size
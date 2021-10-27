require 'pry'

class SimpleLinkedList
  attr_reader :head

  def each
    elt = @head
    until elt.nil?
      yield(elt)
      elt = elt.next
    end
    @head
  end

  def select
    result = @head
    each { |elt| result = @head if yield(elt) }
    result
  end

  def empty?
    @head.nil?
  end

  def push(datum)
    empty? ? @head = Element.new(datum) : @head = Element.new(datum, @head)
  end

  def tail
    select(&:tail?)
  end

  def pop
    current = @head
    if !empty?
      popped = @head.datum
      @head = @head.next
      popped
    else
      current
    end
  end

  def size
    counter = 0
    each { |_| counter += 1 }
    counter
  end

  def peek
    empty? ? nil : @head.datum
  end

  def self.from_a(ary)
    list = new
    ary.reverse_each { |datum| list.push(datum) } unless ary.nil?
    list
  end

  def to_a
    ary = []
    each { |elt| ary << elt.datum }
    ary
  end

  def reverse
    reversed = SimpleLinkedList.new
    each { |elt| reversed.push(elt.datum) }
    reversed
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

list = SimpleLinkedList.from_a([1, 2])
puts list.size
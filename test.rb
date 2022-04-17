def edit_distance(str_a, str_b)
  max = [str_a.size, str_b.size].max
  result = (str_a.size - max).abs
  str_a.size.times do |idx|
    if str_a[idx] != str_b[idx]
      result += 1
    end
  end
  result
end

def levenshtein_distance(str_a, str_b)
  matrix = [[0]]

  str_b.chars.each_with_index do |_, y_idx|
    matrix << [y_idx + 1]
    str_a.chars.each_with_index do |_, x_idx|
      x, y = x_idx + 1, y_idx + 1
      if y_idx == 0
        matrix[y_idx] << x_idx + 1
      end

      sub_cost = 0
      if str_b[y_idx] != str_a[x_idx]
        sub_cost += 1
      end
      matrix[y][x] = [matrix[y_idx][x_idx] + sub_cost, matrix[y_idx][x] + 1, matrix[y][x_idx] + 1].min
    end
  end

  return matrix
end
# levenshtein_distance('sitting', 'kitten')

levenshtein_distance('kitten', 'sitting').each do |row|
  puts row.inspect
end

# class Node
#   attr_accessor :data, :next

#   def initialize(data, next_node = nil)
#     self.data = data
#     self.next = next_node
#   end

#   def print
#     output = "#{data}"
#     next_node = self.next
#     while next_node != nil
#       output << ", #{next_node.data}"
#       next_node = next_node.next
#     end
#     puts output
#   end
# end

# one = Node.new(7)
# two = Node.new(9, one)
# three = Node.new(11, two)

# three.print

# def reverse(node, previous = nil)
#   if node == nil
#     return previous
#   else
#     next_node = node.next
#     node.next = previous
#     previous = node
#     reverse(next_node, previous)
#   end
# end

# reverse(three)

# one.print
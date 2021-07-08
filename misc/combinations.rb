
# [1] + [2] => [[2, 1], [1, 2]]

# [1, 2, 3]
# [1, 2] + [3]
# ([1] + [2]) + [3]
# ([[2, 1], [1, 2]]) + [3]
# [[2, 1, 3], [1, 2, 3], [3, 2, 1], [3, 1, 2], [2, 3, 1], [1, 3, 2]] + [4]
# [[4, 2, 1, 4], [2, 4, 1, 3], [2, 1, 4, 3], [2, 1, 3, 4]

# Method: combine
# Input: Array, Integer
#   - the first is an array
#   - the second is a single element (integer)
# Output: A Nested Array of Integers
#   - all possible combinations of the elements with the integer
#   - do not include duplicates
#   - find all possible combinations of the single element with each array

# Examples:
# p combine([1, 2], 3) == [[2, 1, 3], [1, 2, 3], [3, 2, 1], [3, 1, 2], [2, 3, 1], [1, 3, 2]]

# Algo
# - Save the length of the input array plus one, call it output_len
# - Create a results array
# - Store and track the current place (index) of where to add the single element to results, start at 0
# - Iterate output_len times
#   - Create a placeholder array
#   - if the current iteration index is the same as the single element index
#     - add the single element to the placeholder array
#   - otherwise
#     - add the element at the current iteration index from the input array to the placeholder
#   - Add one to the single element index
#   - Add the placeholder array to results
# - Return results

def combine(ary, single_elt)
  combined = ary + [single_elt]
  current_idx = 0
  result = []

  while current_idx < ary.size
    combined.size.times do |iter_idx|
      current_elt = combined[current_idx]
      other_elts = combined.select.with_index {|_, idx| idx != current_idx}
      placeholder = combine_at_idx(other_elts, current_elt, iter_idx)
      result << placeholder
    end
    current_idx += 1
  end

  result

end

def combine_at_idx(ary, single_elt, single_elt_idx)
  output_len = ary.size + 1
  ary_bounds = ary.size - 1
  result = []
  output_len.times do |iter_idx|
    if iter_idx == single_elt_idx
      result << single_elt
      result << ary[single_elt_idx] if single_elt_idx <= ary_bounds
    else
      result << ary[iter_idx] if iter_idx <= ary_bounds
    end
  end
  result
end

# p combine([1, 2], 3) #== [[2, 1, 3], [1, 2, 3], [3, 2, 1], [3, 1, 2], [2, 3, 1], [1, 3, 2]]
p combine_at_idx([2, 3], 1, 0)
p combine_at_idx([1, 3], 2, 0)
p combine_at_idx([1, 2], 3, 0)
# p combine_at_idx([1, 2], 3, 1)
# p combine_at_idx([1, 2], 3, 2)
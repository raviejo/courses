# 1. Order in descending value
# Solution 1
arr = ['10', '11', '9', '7', '8']
p "Before:"
p arr
arr.sort_by! {|a| a.to_i}.reverse!
p "After"
p arr

# Solution 2

arr = ['10', '11', '9', '7', '8']
p "Before:"
p arr
arr.sort! {|a, b| b.to_i <=> a.to_i}
p "After"
p arr

# 2. How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

p books.sort_by {|book| book[:published]}

# 3. For each of these collection objects demonstrate how you would reference the letter 'g'.
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
p arr1[2][1][3] == 'g'

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
p arr2[1][:third][0] == 'g'

arr3 = [['abc'], ['def'], {third: ['ghi']}]
p arr3[2][:third][0][0] == 'g'

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
p hsh1['b'][1] == 'g'

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
p hsh2[:third].keys[0] == 'g'
p hsh2[:third].key(0) == 'g'

# 4. For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.
arr1 = [1, [2, 3], 4]
p arr1
arr1[1][1] = 4
p arr1
p "---"

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
p arr2
arr2[2] = 4
p arr2
p "---"

hsh1 = {first: [1, 2, [3]]}
p hsh1
hsh1[:first][2][0] = 4
p hsh1
p "---"

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
p hsh2
p hsh2[['a']][:a][2] = 4
p hsh2
p "---"

# 5. Given this nested Hash:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# figure out the total age of just the male members of the family.

# Solution 1
males = munsters.select {|_, munster| munster["gender"] == "male"}
p males.map {|_, male| male["age"]}.sum

# Solution 2
p (munsters.each_with_object(Array.new) do |(_, munster), ages|
  ages << munster["age"] if munster["gender"] == "male"
end.sum)

# Solution 3
total_age = 0
munsters.each_value {|details| total_age += details["age"] if details["gender"] == "male"}
p total_age

# 6. One of the most frequently used real-world string properties is that of "string substitution",
# where we take a hard-coded string and modify it with various parameters from our program.

# Given this previously seen family hash, print out the name, age and gender of each family member:

munsters.each do |name, details|
  p "#{name} is a #{details["age"]}-year-old #{details["gender"]}"
end

# 7. Given this code, what would be the final values of a and b? Try to work this out without
# running the code.
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# a => 2
# b => [3, 8]

# 8. Using the each method, write some code to output all of the vowels from the strings.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |key, value|
  value.each do |word|
    vowels = ""
    word.chars.each do |char|
      vowels << char if char =~ /[aeiou]/i
    end
    p "#{word} has the following vowels: #{vowels}"
  end
end

# 9. Given this data structure, return a new array of the same structure but with the sub arrays being ordered
# (alphabetically or numerically as appropriate) in descending order.
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
p arr
p (arr.map do |sub_arr|
  sub_arr.sort! {|a, b| b <=> a}
end)

# 10. Given the following data structure and without modifying the original array, use the map method to return
# a new array identical in structure to the original but where the value of each integer is incremented by 1.
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

p ([{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  output = {}
  hsh.each do |k, v|
    output[k] = v + 1
  end
  output
end)

p ([{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].each_with_object(Array.new) do |hsh, arr|
  new_hsh = {}
  hsh.each do |k, v|
    new_hsh[k] = v + 1
  end
  arr << new_hsh
end)


# 11. Given the following data structure use a combination of methods, including either the select or reject method,
# to return a new array identical in structure to the original but containing only the integers that are multiples of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

p (arr.map do |sub_arr|
  sub_arr.select do |num|
    num % 3 == 0
  end
end)

# 12. Given the following data structure, and without using the Array#to_h method, write some code that will return a
# hash where the key is the first item in each sub array and the value is the second item.
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

p (arr.each_with_object(Hash.new) do |elt, hsh|
  key = elt[0]
  value = elt[1]
  hsh[key] = value
end)

# 13. Given the following data structure, return a new array containing the same sub-arrays as the original but ordered
# logically by only taking into consideration the odd numbers they contain.
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# The sorted array should look like this:
[[1, 8, 3], [1, 6, 7], [1, 4, 9]]

p (arr.sort_by do |sub_arr|
  sub_arr.select {|n| n.odd?}
end)

# 14. Given this data structure write some code to return an array containing the colors of the fruits and the sizes of
# the vegetables. The sizes should be uppercase and the colors should be capitalized.
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# The return value should look like this:
[["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

p (hsh.map do |_, v|
  if v[:type] == "fruit"
    v[:colors].map {|color| color.capitalize}
  else
    v[:size].upcase
  end
end)

# 15. Given this data structure write some code to return an array which contains only the hashes where all the integers are even.
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
p (arr.select do |hsh|
  hsh.all? do |_, sub_arr|
    sub_arr.all? do |int|
      int.even?
    end
  end
end)

# 16. A UUID is a type of identifier often used as a way to uniquely identify items...which may not all be created by the same system.
# That is, without any form of synchronization, two or more separate computer systems can create new items and label them with a UUID
# with no significant chance of stepping on each other's toes.
# It accomplishes this feat through massive randomization. The number of possible UUID values is approximately 3.4 X 10E38.
# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.

# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Write a method that returns one UUID when called with no parameters.

def uuid()
  sections = "8-4-4-4-12".split("-")
  hex = ("0".."9").to_a + ("a".."z").to_a
  result = []
  sections.each do |count|
    section = []
    count.to_i.times do
      section << hex.sample
    end
    result << section.join
  end

  result.join("-")
end

p uuid()
p uuid()
p uuid()
p uuid()


def letter_percentages(str)
  percentages = {lowercase: "a-z", uppercase: "A-Z", neither: "^A-Za-z"}
  percentages.each {|k, v| percentages[k] = str.count(v) / str.size.to_f * 100}
  percentages
end

p letter_percentages('abCdef 123')
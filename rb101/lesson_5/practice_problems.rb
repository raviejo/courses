# Practice Problem 1
# How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

p arr.sort {|a, b| b.to_i <=> a.to_i }

# Practice Problem 2
# How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

p (books.sort_by do |book|
  book[:published].to_i
end)

# Practice Problem 3
# For each of these collection objects demonstrate how you would reference the letter 'g'.


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


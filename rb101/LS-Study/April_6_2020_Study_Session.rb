=begin

Write a method that takes a string as an argument and groups the number of time each character appears in the string as a hash sorted by the highest number of occurrences.

The characters should be sorted alphabetically. You should ignore spaces, special characters and count uppercase letters as lowercase ones.

PROBLEM
- input: string
- output: hash
- count uppercase letter as lowercase letters
- we're sorting by both highest number of occurrences but also alphabetically: what does that look like?
- creating a method
- ignore non alphabetical characters
  - what do we do with numbers?
  - how do you sort numbers alphabetically?
- two values stored in the hash: characters & the number for the times they occur 
  - which is the key and which is the value?
- What happens if you get an empty string?


EXAMPLES
p get_char_count("cba") == { 1 => ["a", "b", "c"] }
p get_char_count("Mississippi") == { 4 => ["i", "s"], 2 => ["p"], 1 => ["m"] }
p get_char_count("Hello. Hello? HELLO!!") == { 6 => ["l"], 3 => ["e", "h", "o"] }
p get_char_count("aaabbbccc") == { 3 => ["a", "b", "c"] }
p get_char_count("abc123") == { 1 => ["1", "2", "3", "a", "b", "c"] }
p get_char_count("") == {}
p get_char_count("...$*,+") == {}

- empty string => empty hash 
- string with just non alphanumerical characters => empty hash
- grouping all letters that have the same count in the same array
  - within that array, those characters are in alphabetical order
- hash: key: frequency, value: array of characters of that frequency
- numbers go before letters when you sort them 
- looks like numbers are descending in frequency, whereas letters are ascending

DATA STRUCTURES
- strings
- hashes
- arrays
- integers
- booleans (for comparison)
- if/else conditional

ALGORITHM
coderpad.io/sandbox
- Write an algo for Go Lang
- Write it for Theron

---------------------------------------------------
Rebecca
initialize a constant with all characters
initialize a hash
initialize an array 
separate string into characters
iterate through the characters to see if it includes a letter or number
if true, then count the character
  initialize the count as the key, and the letters as the value
or else
  continue iterating to the next character

another method definition?
?? place characters with equal counts in an array
return the hash

---------------------------------------------------
Andrea
- loop and count
- iterate over string
- count objects limited to numbers and letters, but count numbers as string objects not integers
- sort numbers before letters
- organize into hash
- break after iterate over string

- convert all uppercase to lowercase
- delete special characters

---------------------------------------------------
Will

ALGORITHM
-Create something to compare alphanumeric characters (arrau a through z 0 through 9)
-Given a sentence or word
  -Make sure every letter is lowercase, if not change that (downcase method)
  -Change the word/sentence into separated characters (chars array)
  -Get rid of characters that are non alphanumeric (select method)
  -Create an empty hash (initialize variable)
-Go through characters (iterate chars array)
  -If hash doesn't have key of letter count (if false)
    -Key is letter count from word/sentence
    -Value is element within an array
  -If hash does have key or letter count (if true)
    -Value is appended the characters
-Go through letter count hash (iterate hash)
  -Change each grouping of characters by sorting them alphabetically (map array in hash value, sort)
-Sort the hash by character counts
-Turn the array back to an hash

---------------------------------------------------
Ryan
ALGORITHM
- initialize an empty hash
- convert string to an array
- iterate over each element in the array
- if the character is an alphanumeric character
  - count the times the character occurs in the string save as count var
  - if the hash has a key of count
    - check if character is not already in value array
      - add character to the hash value array
  - else if hash has no key of count
    - add a new key of count to hash with a charcter in an array as value
- sort hash by decending order
- sort hash values by alphabetical order

---------------------------------------------------
Ricky
- Create a variable “results” and set it to an empty hash
- Create variable “unique” with the unique alphanumeric characters in the string
  - Use regular expression /^a-zA-z/
- Iterate over each character in unique (“char”)
   - Create variable “count” with the count of “char” occurrences in the string
   - If the key “count” is present in “results”
    - Append “char” to the value (array) at the key of results
    - Sort the value (array) at the key of results
  - Else
   - Add the key “char” to the results hash with a value of array of char
  - End conditional
  - End Iteration
- Return results

---------------------------------------------------
Callie

- create a list of acceptable characters
- create an answer hash
- create a version of the string with only unique characters & lowercase (call it unique_characters)
- look at each unique character
  - if it's not an acceptable character, skip it. 
  - count the amount of times that char is in the input string
  - if that number is already in the hash, add it to the list of characters already there
  - if that number is NOT already in the hash, create it, and set the current character as its character list
- sort all of the lists of characters in the hash, one at a time
- return the answer hash

=end

def get_char_count(str)
  acceptable_characters = ("a".."z").to_a + ("0".."9").to_a
  answer = {}
  unique_characters = str.downcase.chars.uniq
  
  unique_characters.each do |char|
    next if !acceptable_characters.include?(char)
    count = str.downcase.count(char)
    if answer.has_key?(count)
      answer[count] << char
    else
      answer[count] = [char]
    end
  end
  
  answer.each {|k, v| v.sort! }
end


p get_char_count("cba") == { 1 => ["a", "b", "c"] }
p get_char_count("Mississippi") == { 4 => ["i", "s"], 2 => ["p"], 1 => ["m"] }
p get_char_count("Hello. Hello? HELLO!!") == { 6 => ["l"], 3 => ["e", "h", "o"] }
p get_char_count("aaabbbccc") == { 3 => ["a", "b", "c"] }
p get_char_count("abc123") == { 1 => ["1", "2", "3", "a", "b", "c"] }
p get_char_count("") == {}
p get_char_count("...$*,+") == {}
# EXAMPLE 1

# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.

# change_me("We will meet at noon") == "We will meet at NOON"
# change_me("No palindromes here") == "No palindromes here"
# change_me("") == ""
# change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"

# Input: string
# Output: string (not the same object)
# Rules:
#      Explicit Requirements:
#       - Every palindrom in the string must be converted to uppercase.
#         A palindrome is a word that reads the same forwards and back-
#         wards.
#       - Palindromes are case sensitive, so "Dad" is not a palindrome,
#         but "dad" is.

#      Implicit Requirements:
#       - The output must be a new string object.
#       - If the input is an empty string, the output must be an empty array

# EXAMPLE 2

# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# Questions
# 1. What is a substring
# 2. What is a palindrome
# 3. Will inputs always be strings?
# 4. What does it mean that palindromes are case sensitive?

# Input: string
# Output: array of strings
# Rules:
#       Explicit Requirements:
#        - Every palindrome in the string must be returned as an element
#          an array. A palindrome is a word that reads the same forwards
#          as it does backwards.
#        - Palindromes are case sensitive so "Bob" is not a palindrome,
#          but "bob" is. 

#       Implicit Requirements:
#        - The output must be an array of strings. Each string in the array
#          must be a palindrome.
#        - If given an empty string or a string without any palindromes, the
#          method should return an empty array

# Algorithm
# substrings method
# =================
#        - Create a `result` variable (empty array) that will contain all required substrings
#        - Create a `starting_index` (value `0`) for the starting index of the substring
#        - While the "starting index" is less than "string.size" - 1
#          - Create a `num_chars` variable (value `2`) for the size of a substring
#          - While `num_chars` <= `string.size` - `starting_index`
#            - Create a `substring` variable and set it the substring from `starting_index` of `num_chars` size from `string`
#            - Append `substring` to the `result` array
#            - Increment `num_chars` by 1
#          - End while loop
#          - Increase `starting_index` by 1
#        - End while loop
#        - Return `result`

# is_palindrome? method
# =====================
#        - Check whether the `string` value is equal to its reversed value.
#          Use the String#reverse method.

# palindrome_substrings method
# ============================
#        - Create a `result` variable (empty array) that will contain all of the palindrome substrings
#          - Loop through the substrings of the `string`. Use the `substrings` method.
#            - Append each substring that is a palindrome to the `result` array.
#              Use the `is_palindrome?` method.
#          - End loop
#        - Return result

def substrings(str)
  starting_index = 0
  result = []

  while starting_index < str.size - 1
    num_chars = 2
    while num_chars <= str.size - starting_index
      substring = str[starting_index, num_chars]
      result << substring
      num_chars += 1
    end
    starting_index += 1
  end
  result
end

def is_palindrome?(str)
  str == str.reverse
end

def palindrome_substrings(str)
  result = []
  for substring in substrings(str)
    result << substring if is_palindrome?(substring)
  end
  result
end


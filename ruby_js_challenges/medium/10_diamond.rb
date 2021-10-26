class Diamond
  
  # - Create a results string
  # - Get a range of all letters from A to the given letter
  # - Get the size of the range starting from A all the way to the given letter, call it center
  # - Create an array of lines, call it `non_centered`
  # - Get all of the odd numbers starting at 1 until the size of the range
  # - Iterate through each letter in the range, 
  #   - If the letter is "A", add it to non_centered
  #   - Otherwise remove the first from odd_numbers and store it as space_between
  #   - Create a string by concatenating the current letter, blank strings (space_between times), and the current_letter
  # - Create a new list by reversing non_centered, dropping the first, and adding it to non_centered
  # - Iterate through non_centered:
  #   - Center it in between the size of the range
  #   - Add a new line control character
  #   - Add it to results
  # - Return results
  
  def self.make_diamond(letter)
    results = ""
    range = ("A"..letter).to_a
    size = range.size
    non_centered = []
    max_line_size = (size * 2) - 1
    spaces = (1..max_line_size).select(&:odd?)
    
    range.each do |letter|
      space = spaces.shift unless letter == "A"
      line = space ? "#{letter}#{" " * space}#{letter}" : letter
      non_centered << line
    end
    
    non_centered = non_centered + non_centered.reverse[1..-1]
    
    non_centered.each do |line|
      centered = line.center(max_line_size)
      centered << "\n"
      results << centered
    end
    
    results
  end
end

puts Diamond.make_diamond("A")
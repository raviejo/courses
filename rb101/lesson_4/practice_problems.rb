flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones.each_with_index {|v, i| flintstones_hash[v] = i}

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.sum

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.reject! {|k, v| v > 100}

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.min

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.select {|name| name[0..1] == "Be"}

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! {|name| name[0,3]}

statement = "The Flintstones Rock"
statement.chars.each_with_object(Hash.new) do |char, hash|
  if hash.has_key?(char)
    hash[char] += 1
  else
    hash[char] = 1
  end
end

words = "the flintstones rock"
words.split(" ").map do |word|
  word[0] = word[0].upcase
  word
end.join(" ")

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |munster, _|
  age = munsters[munster]["age"]
  munsters[munster]["age_group"] = case age
                                   when 0...18 then "kid"
                                   when 18...64 then "adult"
                                   else "senior"
                                   end
end




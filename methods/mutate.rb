a = [1, 2, 3]

def mutate(array)
  array.pop
end

def no_mutate(array)
  array.last
end

p "Before mutate method: #{a}"
mutate(a)
p "After mutate method: #{a}"
no_mutate(a)
p "After no-mutate method: #{a}"
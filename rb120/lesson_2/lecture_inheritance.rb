# 1. 
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

class Bulldog < Dog
  def swim
    'can\'t swim!'
  end
end

karl = Bulldog.new
puts karl.speak # => "bark!"
puts karl.swim # => "can't swim!"

# 2. Let's create a few more methods for our Dog class.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

# 3.
=begin
Pet class:
> Pet
> Object
> Kernel
> BasicObject

Dog class:
> Dog
> Pet
> Object
> Kernel
> BasicObject

Cat Class
> Cat
> Pet
> Object
> Kernel
> BasicObject

Bulldog Class
> Bulldog
> Dog
> Pet
> Object
> Kernel
> BasicObject

=end
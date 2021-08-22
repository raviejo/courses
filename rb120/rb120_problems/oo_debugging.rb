# 1. Community Library
# On line 42 of our code, we intend to display information regarding the books currently checked in to our community library.
# Instead, an exception is raised. Determine what caused this error and fix the code so that the data is displayed as expected.

# class Library
#   attr_accessor :address, :phone, :books

#   def initialize(address, phone)
#     @address = address
#     @phone = phone
#     @books = []
#   end

#   def check_in(book)
#     books.push(book)
#   end

#   def display_books
#     books.each(&:display_data)
#   end
# end

# class Book
#   attr_accessor :title, :author, :isbn

#   def initialize(title, author, isbn)
#     @title = title
#     @author = author
#     @isbn = isbn
#   end

#   def display_data
#     puts "---------------"
#     puts "Title: #{title}"
#     puts "Author: #{author}"
#     puts "ISBN: #{isbn}"
#     puts "---------------"
#   end
# end

# community_library = Library.new('123 Main St.', '555-232-5652')
# learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
# little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
# wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

# community_library.check_in(learn_to_program)
# community_library.check_in(little_women)
# community_library.check_in(wrinkle_in_time)

# community_library.books.each(&:display_data) # => first answer, call each and pass display data
# community_library.display_books # => second answer, display data on the library object

# 2. Animal Kingdom
# The code below raises an exception. Examine the error message and alter the code so that it runs without error.
# class Animal
#   def initialize(diet, superpower)
#     @diet = diet
#     @superpower = superpower
#   end

#   def move
#     puts "I'm moving!"
#   end

#   def superpower
#     puts "I can #{@superpower}!"
#   end
# end

# class Fish < Animal
#   def move
#     puts "I'm swimming!"
#   end
# end

# class Bird < Animal
# end

# class FlightlessBird < Bird
#   def initialize(diet, superpower)
#     super
#   end

#   def move
#     puts "I'm running!"
#   end
# end

# class SongBird < Bird
#   def initialize(diet, superpower, song)
#     super(diet, superpower)
#     @song = song
#   end

#   def move
#     puts "I'm flying!"
#   end
# end

# # Examples

# unicornfish = Fish.new(:herbivore, 'breathe underwater')
# penguin = FlightlessBird.new(:carnivore, 'drink sea water')
# robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# 3. Wish You Were Here
# On lines 37 and 38 of our code, we can see that grace and ada are located at the same coordinates.
# So why does line 39 output false? Fix the code to produce the expected output.
# class Person
#   attr_reader :name
#   attr_accessor :location

#   def initialize(name)
#     @name = name
#   end

#   def teleport_to(latitude, longitude)
#     @location = GeoLocation.new(latitude, longitude)
#   end
# end

# class GeoLocation
#   attr_reader :latitude, :longitude

#   def initialize(latitude, longitude)
#     @latitude = latitude
#     @longitude = longitude
#   end

#   def to_s
#     "(#{latitude}, #{longitude})"
#   end

#   def ==(other)
#     latitude == other.latitude && longitude == other.longitude
#   end
# end

# # Example

# ada = Person.new('Ada')
# ada.location = GeoLocation.new(53.477, -2.236)

# grace = Person.new('Grace')
# grace.location = GeoLocation.new(-33.89, 151.277)

# ada.teleport_to(-33.89, 151.277)

# puts ada.location                   # (-33.89, 151.277)
# puts grace.location                 # (-33.89, 151.277)
# puts ada.location == grace.location # expected: true
#                                     # actual: false

# 4. Employee Management
# We have written some code for a simple employee management system. Each employee must have a unique
# serial number. However, when we are testing our program, an exception is raised. Fix the code so
# that the program works as expected without error.

# class EmployeeManagementSystem
#   attr_reader :employer

#   def initialize(employer)
#     @employer = employer
#     @employees = []
#   end

#   def add(employee)
#     if exists?(employee)
#       puts "Employee serial number is already in the system."
#     else
#       employees.push(employee)
#       puts "Employee added."
#     end
#   end

#   alias_method :<<, :add

#   def remove(employee)
#     if !exists?(employee)
#       puts "Employee serial number is not in the system."
#     else
#       employees.delete(employee)
#       puts "Employee deleted."
#     end
#   end

#   def exists?(employee)
#     employees.any? { |e| e == employee }
#   end

#   def display_all_employees
#     puts "#{employer} Employees: "

#     employees.each do |employee|
#       puts ""
#       puts employee.to_s
#     end
#   end

#   private

#   attr_accessor :employees
# end

# class Employee
#   attr_reader :name

#   def initialize(name, serial_number)
#     @name = name
#     @serial_number = serial_number
#   end

#   def ==(other)
#     serial_number == other.serial_number
#   end

#   protected

#   attr_reader :serial_number

#   def abbreviated_serial_number
#     serial_number[-4..-1]
#   end
# end

# # Example

# miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

# becca = Employee.new('Becca', '232-4437-1932')
# raul = Employee.new('Raul', '399-1007-4242')
# natasha = Employee.new('Natasha', '399-1007-4242')

# miller_contracting << becca     # => Employee added.
# miller_contracting << raul      # => Employee added.
# miller_contracting << raul      # => Employee serial number is already in the system.
# miller_contracting << natasha   # => Employee serial number is already in the system.
# miller_contracting.remove(raul) # => Employee deleted.
# miller_contracting.add(natasha) # => Employee added.

# miller_contracting.display_all_employees

# 5. Files
# You started writing a very basic class for handling files. However, when you begin to write some simple test code,
# you get a NameError. The error message complains of an uninitialized constant File::FORMAT.

# What is the problem and what are possible ways to fix it?
# class File
#   attr_accessor :name, :byte_content

#   def initialize(name)
#     @name = name
#   end

#   alias_method :read,  :byte_content
#   alias_method :write, :byte_content=

#   def copy(target_file_name)
#     target_file = self.class.new(target_file_name)
#     target_file.write(read)

#     target_file
#   end

#   def to_s
#     "#{name}.#{self.class::FORMAT}"
#   end
# end

# class MarkdownFile < File
#   FORMAT = :md
# end

# class VectorGraphicsFile < File
#   FORMAT = :svg
# end

# class MP3File < File
#   FORMAT = :mp3
# end

# # Test

# blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
# blog_post.write('Content will be added soon!'.bytes)

# copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

# puts copy_of_blog_post.is_a? MarkdownFile     # true
# puts copy_of_blog_post.read == blog_post.read # true

# puts blog_post

# 6. Sorting Distances
# When attempting to sort an array of various lengths, we are surprised to see that an ArgumentError is raised. Make the necessary changes to our
# code so that the various lengths can be properly sorted and line 62 produces the expected output.

# class Length
#   attr_reader :value, :unit

#   def initialize(value, unit)
#     @value = value
#     @unit = unit
#   end

#   def as_kilometers
#     convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
#   end

#   def as_miles
#     convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
#   end

#   def as_nautical_miles
#     convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
#   end

#   def <=>(other)
#     case unit
#     when :km  then value <=> other.as_kilometers.value
#     when :mi  then value <=> other.as_miles.value
#     when :nmi then value <=> other.as_nautical_miles.value
#     end
#   end

#   def ==(other)
#     case unit
#     when :km  then value == other.as_kilometers.value
#     when :mi  then value == other.as_miles.value
#     when :nmi then value == other.as_nautical_miles.value
#     end
#   end

#   def <(other)
#     case unit
#     when :km  then value < other.as_kilometers.value
#     when :mi  then value < other.as_miles.value
#     when :nmi then value < other.as_nautical_miles.value
#     end
#   end

#   def <=(other)
#     self < other || self == other
#   end

#   def >(other)
#     !(self <= other)
#   end

#   def >=(other)
#     self > other || self == other
#   end

#   def to_s
#     "#{value} #{unit}"
#   end

#   private

#   def convert_to(target_unit, conversion_factors)
#     Length.new((value / conversion_factors[unit]).round(4), target_unit)
#   end
# end

# # Example

# puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# # => comparison of Length with Length failed (ArgumentError)
# # expected output:
# # 1 km
# # 1 mi
# # 1 nmi

# (Length.new(10, :km).as_nautical_miles.as_kilometers - Length.new(10, :km)).abs < 0.001 # => true

# 7. Bank Balance
# We created a simple BankAccount class with overdraft protection, that does not allow a withdrawal greater than the amount of the current balance.
# We wrote some example code to test our program. However, we are surprised by what we see when we test its behavior. Why are we seeing this
# unexpected output? Make changes to the code so that we see the appropriate behavior.

# class BankAccount
#   attr_reader :balance

#   def initialize(account_number, client)
#     @account_number = account_number
#     @client = client
#     @balance = 0
#   end

#   def deposit(amount)
#     if amount > 0
#       self.balance += amount
#       "$#{amount} deposited. Total balance is $#{balance}."
#     else
#       "Invalid. Enter a positive amount."
#     end
#   end

#   def withdraw(amount)
#     if amount < balance
#       success = (self.balance -= amount)
#     else
#       success = false
#     end

#     if success
#       "$#{amount} withdrawn. Total balance is $#{balance}."
#     else
#       "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
#     end
#   end

#   def balance=(new_balance)
#     @balance = new_balance
#   end

#   def valid_transaction?(new_balance)
#     new_balance >= 0
#   end
# end

# # Example

# account = BankAccount.new('5538898', 'Genevieve')

#                           # Expected output:
# p account.balance         # => 0
# p account.deposit(50)     # => $50 deposited. Total balance is $50.
# p account.balance         # => 50
# p account.withdraw(10)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
#                           # Actual output: $80 withdrawn. Total balance is $50.
# p account.balance         # => 50

# 8. Task Manager
# Valentina is using a new task manager program she wrote. When interacting with her task manager, an error is
# raised that surprises her. Can you find the bug and fix it?

# class TaskManager
#   attr_reader :owner
#   attr_accessor :tasks

#   def initialize(owner)
#     @owner = owner
#     @tasks = []
#   end

#   def add_task(name, priority=:normal)
#     task = Task.new(name, priority)
#     tasks.push(task)
#   end

#   def complete_task(task_name)
#     completed_task = nil

#     tasks.each do |task|
#       completed_task = task if task.name == task_name
#     end

#     if completed_task
#       tasks.delete(completed_task)
#       puts "Task '#{completed_task.name}' complete! Removed from list."
#     else
#       puts "Task not found."
#     end
#   end

#   def display_all_tasks
#     display(tasks)
#   end

#   def display_high_priority_tasks
#     high_priority_tasks = tasks.select do |task|
#       task.priority == :high
#     end

#     display(high_priority_tasks)
#   end

#   private

#   def display(tasks)
#     puts "--------"
#     tasks.each do |task|
#       puts task
#     end
#     puts "--------"
#   end
# end

# class Task
#   attr_accessor :name, :priority

#   def initialize(name, priority=:normal)
#     @name = name
#     @priority = priority
#   end

#   def to_s
#     "[" + sprintf("%-6s", priority) + "] #{name}"
#   end
# end

# valentinas_tasks = TaskManager.new('Valentina')

# valentinas_tasks.add_task('pay bills', :high)
# valentinas_tasks.add_task('read OOP book')
# valentinas_tasks.add_task('practice Ruby')
# valentinas_tasks.add_task('run 5k', :low)

# valentinas_tasks.complete_task('read OOP book')

# valentinas_tasks.display_all_tasks
# valentinas_tasks.display_high_priority_tasks

# 9. You've Got Mail!
# Can you decipher and fix the error that the following code produces?
# class Mail
#   def to_s
#     "#{self.class}"
#   end
# end

# class Email < Mail
#   attr_accessor :subject, :body

#   def initialize(subject, body)
#     @subject = subject
#     @body = body
#   end
# end

# class Postcard < Mail
#   attr_reader :text

#   def initialize(text)
#     @text = text
#   end
# end

# module Mailing
#   def receive(mail, sender)
#     mailbox << mail unless reject?(sender)
#   end

#   # Change if there are sources you want to block.
#   def reject?(sender)
#     false
#   end

#   def send(destination, mail)
#     "Sending #{mail} from #{name} to: #{destination}"
#     # Omitting the actual sending.
#   end
# end

# class CommunicationsProvider
#   attr_reader :name, :account_number

#   include Mailing

#   def initialize(name, account_number=nil)
#     @name = name
#     @account_number = account_number
#   end
# end

# class EmailService < CommunicationsProvider
#   # include Mailing

#   attr_accessor :email_address, :mailbox

#   def initialize(name, account_number, email_address)
#     super(name, account_number)
#     @email_address = email_address
#     @mailbox = []
#   end

#   def empty_inbox
#     self.mailbox = []
#   end
# end

# class TelephoneService < CommunicationsProvider
#   def initialize(name, account_number, phone_number)
#     super(name, account_number)
#     @phone_number = phone_number
#   end
# end

# class PostalService < CommunicationsProvider
#   attr_accessor :street_address, :mailbox
#   # include Mailing

#   def initialize(name, street_address)
#     super(name)
#     @street_address = street_address
#     @mailbox = []
#   end

#   def change_address(new_address)
#     self.street_address = new_address
#   end
# end

# rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
# johns_phone_service   = TelephoneService.new('John', 122, '555-232-1121')
# johns_postal_service  = PostalService.new('John', '47 Sunshine Ave.')
# ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

# puts johns_postal_service.send(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# # => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)

# 10. Does it Rock or Not?
# We discovered Gary Bernhardt's repository for finding out whether something rocks or not, and decided to adapt it for a simple example.
# class AuthenticationError < StandardError; end

# # A mock search engine
# # that returns a random number instead of an actual count.
# class SearchEngine
#   def self.count(query, api_key)
#     unless valid?(api_key)
#       raise AuthenticationError, 'API key is not valid.'
#     end

#     rand(200_000)
#   end

#   private

#   def self.valid?(key)
#     key == 'LS1A'
#   end
# end

# module DoesItRock
#   API_KEY = 'LS1A'

#   class NoScore; end

#   class Score
#     def self.for_term(term)
#       positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
#       negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

#       positive / (positive + negative)
#     rescue ZeroDivisionError
#       NoScore.new
#     end
#   end

#   def self.find_out(term)
#     score = Score.for_term(term)

#     case score
#     when NoScore
#       "No idea about #{term}..."
#     when 0...0.5
#       "#{term} is not fun."
#     when 0.5
#       "#{term} seems to be ok..."
#     else
#       "#{term} rocks!"
#     end
#   rescue StandardError => e
#     e.message
#   end
# end

# # Example (your output may differ)

# puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

# class AuthenticationError < Exception; end

# # A mock search engine
# # that returns a random number instead of an actual count.
# class SearchEngine
#   def self.count(query, api_key)
#     unless valid?(api_key)
#       raise AuthenticationError, 'API key is not valid.'
#     end

#     rand(200_000)
#   end

#   private

#   def self.valid?(key)
#     key == 'LS1B'
#   end
# end

# module DoesItRock
#   API_KEY = 'LS1A'

#   class NoScore; end

#   class Score
#     def self.for_term(term)
#       positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
#       negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

#       positive / (positive + negative)
#     rescue Exception
#       NoScore
#     end
#   end

#   def self.find_out(term)
#     score = Score.for_term(term)

#     case score
#     when NoScore
#       "No idea about #{term}..."
#     when 0...0.5
#       "#{term} is not fun."
#     when 0.5
#       "#{term} seems to be ok..."
#     else
#       "#{term} rocks!"
#     end
#   rescue Exception => e
#     e.message
#   end
# end

# # Example (your output may differ)

# puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

# class SearchEngineError < StandardError; end
# class AuthenticationError < SearchEngineError; end
# class NoScore < SearchEngineError; end

# # A mock search engine
# # that returns a random number instead of an actual count.
# class SearchEngine
#   def self.count(query, api_key)
#     unless valid?(api_key)
#       raise AuthenticationError, 'API key is not valid.'
#     end

#     rand(200_000)
#   end

#   private

#   def self.valid?(key)
#     key == 'LS1B'
#   end
# end

# module DoesItRock
#   API_KEY = 'LS1A'

#   class NoScore; end

#   class Score
#     def self.for_term(term)
#       positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
#       negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

#       positive / (positive + negative)
#     rescue ZeroDivisionError => e
#       NoScore.new
#     end
#   end

#   def self.find_out(term)
#     score = Score.for_term(term)

#     case score
#     when NoScore
#       "No idea about #{term}..."
#     when 0...0.5
#       "#{term} is not fun."
#     when 0.5
#       "#{term} seems to be ok..."
#     else
#       "#{term} rocks!"
#     end
#   rescue SearchEngineError => e
#     e.message
#   end
# end

# # Example (your output may differ)

# puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!


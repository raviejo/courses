class Robot
  @@names = []
  
  attr_reader :name
  
  def initialize
    generate_name
  end
  
  def generate_name
    potential_name = new_name while @@names.include?(potential_name)
    @name = potential_name
    @@names << @name
  end
  
  def new_name
    new_name = ''
    2.times { new_name << ("A".."Z").to_a.shuffle[0] }
    3.times { new_name << (0..9).to_a.shuffle[0].to_s }
    new_name
  end
  
  alias :reset :generate_name
end
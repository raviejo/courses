require "minitest/autorun"
require "minitest/reporters"
require "simplecov"

Minitest::Reporters.use!
SimpleCov.start

require_relative "../todo_list"

class TodoListTests < Minitest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @todos.each { |todo| @list << todo }
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    @list.mark_all_done
    assert(@list.done?)
  end

  def test_type_error
    assert_raises(TypeError) { @list << 'hello' }
    assert_raises(TypeError) { @list << 7 }
  end

  def test_shovel
    list = TodoList.new("Today's Todos")
    list << @todo1
    assert_equal([@todo1], list.to_a)
  end

  def test_add
    list = TodoList.new("Today's Todos")
    list.add(@todo1)
    assert_equal([@todo1], list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) do
      @list.item_at(3)
    end
    assert_equal(@todo3, @list.item_at(2))
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_at
    assert_raises(IndexError) do
      @list.mark_done_at(3)
    end
    @list.mark_done_at(2)
    refute(@list.item_at(0).done?)
    refute(@list.item_at(1).done?)
    assert(@list.item_at(2).done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) do
      @list.mark_undone_at(3)
    end

    @list.mark_all_done
    @list.mark_undone_at(2)
    assert(@list.item_at(0).done?)
    assert(@list.item_at(1).done?)
    refute(@list.item_at(2).done?)
  end

  def test_done!
    @list.done!
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
    assert(@list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) do
      @list.remove_at(3)
    end
    assert_equal(@todo3, @list.remove_at(2))
    assert_equal(2, @list.size)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(0)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each { |todo| todo.done! }
    assert(@list.done?)
  end

  def test_each_return
    value = @list.each {}
    assert_equal(@list, value)
  end

  def test_select
    result = @list.select { |todo| todo == @todo1 }
    assert_equal(@todo1, result.first)
  end
end
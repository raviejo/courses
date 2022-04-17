class SessionPersistence
  def initialize(session)
    @session = session
    @session[:lists] ||= []
  end

  def create_new_list(name)
    id = get_next_id(all_lists)
    all_lists << { id: id, name: name, todos: [] }
  end

  def all_lists
    @session[:lists]
  end
  
  def find_list(id)
    list = all_lists.find { |list| list[:id] == id }
    list = list if id && list
    return list if list
  end

  def error=(msg)
    @session[:error] = msg
  end

  def success=(msg)
    @session[:success] = msg
  end

  # Check if the list name is unique
  def unique_name?(list_name)
    all_lists.map { |list| list[:name] }.include? list_name
  end
  
  def delete_list(id)
    all_lists.reject! { |list| list[:id] == id }
  end

  def update_list_name(id, new_name)
    list = find_list(id)
    list[:name] = new_name
  end

  def create_new_todo(id, name)
    list = find_list(id)
    todos = list[:todos]
    id = get_next_id(todos)
    todos << { id: id, name: name, completed: false }
  end

  def delete_todo_from_list(list_id, todo_id)
    list = find_list(list_id)
    todos = list[:todos]
    todos.reject! { |todo| todo[:id] == todo_id }
  end

  def update_todo_status(list_id, todo_id, new_status)
    list = find_list(list_id)
    todo = list[:todos].find { |t| t[:id] == todo_id }
    todo[:completed] = new_status
  end

  def mark_all_todos_as_completed(list_id)
    list = find_list(list_id)
    list[:todos].each { |item| item[:completed] = true }
  end

  private

  def get_next_id(collection)
    max = collection.map { |item| item[:id] }.max
    max ||= 0
    max + 1
  end
end


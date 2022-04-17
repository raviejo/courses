require 'sinatra'
require 'sinatra/content_for'
require 'tilt/erubis'

# adapter used to persist the data of the app
require_relative 'database_persistence'

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure(:development) do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
  require 'sinatra/reloader'
  also_reload 'database_persistence.rb'
end

# helper methods used in the views
helpers do
  def list_complete?(list)
    todos_remaining_count(list) == 0 && todos_count(list) > 0
  end

  def todos_count(list)
    list[:todos].size
  end

  def todos_remaining_count(list)
    list[:todos].select do |todo|
      !todo[:completed]
    end.count
  end

  def list_class(list)
    'complete' if list_complete?(list)
  end

  def sort_lists(lists, &block)
    sorted = lists.sort_by { |list| list_complete?(list) ? 1 : 0 }
    yield_sorted(sorted, lists, &block)
  end

  def sort_todos(todos, &block)
    sorted = todos.sort_by { |todo| todo[:completed] ? 1 : 0 }
    yield_sorted(sorted, todos, &block)
  end

  def yield_sorted(sorted_list, unsorted_list, &block)
    sorted_list.each do |list|
      idx = unsorted_list.index(list)
      block.call(list, idx)
    end
  end

end

# Set the session lists
before do
  @storage = DatabasePersistence.new(logger, session)
end

# GET   /lists         -> view all lists
# GET   /lists/new     -> new list form
# POST  /lists         -> crete new list
# GET   /lists/1       -> view a single list

not_found do
  redirect '/lists'
end

# Set the redirect for the homepage
get '/' do
  redirect '/lists'
end

# View list of lists
get '/lists' do
  @lists = @storage.all_lists
  erb :lists
end

# Render the new list form
get '/lists/new' do
  erb :new_list
end

# View a single list
get '/lists/:list_id' do
  list_id = params[:list_id].to_i
  @list = load_list(list_id)
  erb :list
end

# Edit list page
get '/lists/:list_id/edit' do
  list_id = params[:list_id].to_i
  @list = @storage.find_list(list_id)
  redirect '/lists' unless @list
  @current_name = @list[:name]
  erb :edit_list
end

# Edit a list
post '/lists/:list_id' do
  list_id = params[:list_id].to_i
  new_name = params[:list_name].strip

  handle_route(list_name: new_name, error_tmp: :edit_list) do
    @storage.update_list_name(list_id, new_name)
    @storage.success = 'The list has been updated.'
    redirect "/lists/#{list_id}"
  end
end

# Delete a list
post '/lists/:list_id/destroy' do
  list_id = params[:list_id].to_i
  list = @storage.find_list(list_id)
  redirect '/lists' unless list

  @storage.delete_list(list_id)

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    "/lists"
  else
    handle_route do
      @storage.delete_list(list_id)
      @storage.success = "List '#{list[:name]}' has been deleted."
      redirect '/lists'
    end
  end
end

# Add a todo item to a list
post '/lists/:list_id/todos' do
  list_id = params[:list_id].to_i
  @list = @storage.find_list(list_id)
  redirect '/lists' unless @list
  todos = @list[:todos]
  name = params[:todo].strip

  handle_route(todos: todos, todo_name: name, error_tmp: :list) do
    @storage.create_new_todo(list_id, name)
    @storage.success = 'The todo item has been added.'
    redirect "/lists/#{list_id}"
  end
end

# Mark a todo item complete
post '/lists/:list_id/todos/:todo_id' do
  list_id = params[:list_id].to_i
  todo_id = params[:todo_id].to_i
  is_completed = params[:completed] == 'true'
  puts "is_completed => #{is_completed}"

  handle_route do
    @storage.update_todo_status(list_id, todo_id, is_completed)
    redirect "/lists/#{list_id}"
  end
end

# Crete a new list
post '/lists' do
  new_name = params[:list_name].strip
  handle_route(list_name: new_name) do
    @storage.create_new_list(new_name)
    @storage.success = 'The list has been created.'
    redirect '/lists'
  end
end

# Delete a todo item
post '/lists/:list_id/todos/:todo_id/destroy' do
  list_id = params[:list_id].to_i
  todo_id = params[:todo_id].to_i
  @storage.delete_todo_from_list(list_id, todo_id)

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    status 204
  else
    handle_route do
      @storage.success = 'The todo item has been deleted.'
      redirect "/lists/#{list_id}"
    end
  end
end

# Mark all todos as complete for a list
post '/lists/:list_id/complete_all' do
  list_id = params[:list_id].to_i
  @list = @storage.find_list(list_id)
  redirect '/lists' unless @list
  todos = @list[:todos]

  handle_route do
    @storage.mark_all_todos_as_completed(list_id)
    @storage.success = 'All todo items have been marked complete.'
    redirect "/lists/#{list_id}"
  end
end


# Check if the name's size is valid
def valid_size?(name)
  (1..100).cover? name.size
end

def handle_route(list_name: nil, todos: nil, todo_name: nil, error_tmp: nil, &success)
  error_tmp = (error_tmp || :new_list)

  # Check for errors with the list name or todo name
  list_name_tmp = error_for_list_name(list_name) if list_name
  todo_name_tmp = error_for_todo_name(todos, todo_name) if todos

  # Call the block if there are no errors. This will return immediately
  success.call unless (list_name_tmp || todo_name_tmp)

  # Otherwise, display error templates
  if list_name_tmp
    display_error_template(error_tmp) { list_name_tmp }
  elsif todo_name_tmp
    display_error_template(error_tmp) { todo_name_tmp }
  end
end

# Log the error to the session and return an erb template based on the error
def display_error_template(error_tmp, &block)
  error = block.call
  if error
    @storage.error = error
    erb error_tmp
  end
end

# Return an error message if the name is invalid.
# Return nil if name is valid
def error_for_list_name(list_name)
  name = list_name.strip
  if !valid_size?(name)
   'The list name must be between 1 and 100 characters'
  elsif @storage.unique_name?(name)
    'List name must be unique.'
  end
end

def error_for_todo_name(todos, todo_name)
  puts "checking for todo name error"
  name = todo_name.strip
  name_taken = todos.any? { |todo| todo[:name] == name }
  if !valid_size?(name)
    'The todo item name must be between 1 and 100 characters'
  elsif name_taken
    'Todo item name must be unique'
  end
end

def load_list(id)
  list = @storage.find_list(id)
  return list if list
  #@storage.error = "The specified list was not found."
  redirect '/lists' unless @list
end


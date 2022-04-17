require "pg"

class DatabasePersistence
  def initialize(logger, session)
    @db = if Sinatra::Base.production?
            PG.connect(ENV["DATABASE_URL"])
          else
            PG.connect(dbname: "todos")
          end
    @logger = logger
    @session = session
  end

  def create_new_list(name)
    sql = "INSERT INTO lists (name) VALUES ($1)"
    query(sql, name)
  end


  def find_list(id)
    sql = <<~SQL
          SELECT l.id "list_id",
                 l.name "list_name",
                 t.id "todo_id",
                 t.name "todo_name",
                 t.completed "todo_completed"
          FROM lists l
          LEFT OUTER JOIN todos t
          ON t.list_id = l.id
          WHERE l.id = $1
          SQL
    result = query(sql, id)
    todos = []
    result.each do |tuple|
      todo = todo_from_tuple(tuple)
      todos << todo if todo
    end
    list = result.first
    {id: list["list_id"], name: list["list_name"], todos: todos}
  end
  
#  def find_list(id)
#    sql = "SELECT * FROM lists WHERE id = $1"
#    result = query(sql, id)
#    list = result.first
#    sql = "SELECT * FROM todos WHERE list_id = $1"
#    result = query(sql, id)
#    todos = result.map do |todo|
#      is_complete = todo["completed"] == "t"
#      {id: todo["id"], name: todo["name"], completed: is_complete}
#    end
#    {id: list["id"], name: list["name"], todos: todos}
#  end

  def all_lists
    sql = <<~SQL
          SELECT l.id "list_id",
                 l.name "list_name",
                 t.id "todo_id",
                 t.name "todo_name",
                 t.completed "todo_completed"
          FROM lists l
          LEFT OUTER JOIN todos t
          ON t.list_id = l.id
          SQL
    result = query(sql)
    lists_hash = {}

    result.each do |tuple|
      list_id = tuple["list_id"].to_i
      todo = todo_from_tuple(tuple)

      if lists_hash.include?(list_id)
        lists_hash[list_id][:todos] << todo if todo
      else
        lists_hash[list_id] = {id: list_id,
                          name: tuple["list_name"],
                          todos: []}
        lists_hash[list_id][:todos] << todo if todo
      end

    end
    lists = lists_hash.values
  end

#  def all_lists
#    sql = "SELECT * FROM lists"
#    lists = query(sql)
#    sql = "SELECT * FROM todos"
#    todos = query(sql)
#    lists.map do |list|
#      todos_list = todos.select { |todo| todo["list_id"] == list["id"] }
#      todos_list = todos_list.map do |todo|
#        is_complete = todo["completed"] == "t"
#        {id: todo["id"], name: todo["name"], completed: is_complete}
#      end
#      {id: list["id"], name: list["name"], todos: todos_list}
#    end
#  end

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
    query("DELETE FROM todos WHERE list_id = $1", id)
    query("DELETE FROM lists WHERE id = $1", id)
  end

  def update_list_name(id, new_name)
    sql = "UPDATE lists SET name = $2 WHERE id = $1"
    query(sql, id, new_name)
  end

  def create_new_todo(id, name)
    sql = "INSERT INTO todos (list_id, name) VALUES ($1, $2)"
    query(sql, id, name)
  end

  def delete_todo_from_list(list_id, todo_id)
    sql = "DELETE FROM todos WHERE list_id = $1 AND id = $2"
    query(sql, list_id, todo_id)
  end

  def update_todo_status(list_id, todo_id, new_status)
    sql = <<~SQL
          UPDATE todos
          SET completed = $1
          WHERE id = $2
          SQL
    query(sql, new_status, todo_id)
  end

  def mark_all_todos_as_completed(list_id)
    sql = <<~SQL
          UPDATE todos
          SET completed = true
          WHERE list_id = $1
          SQL
    query(sql, list_id)
  end

  private

  def is_complete(tuple)
    result = tuple["todo_completed"]
    result = !!result && result == "t"
  end

  def todo_from_tuple(tuple)
    tuple["todo_id"] && {id: tuple["todo_id"].to_i,
                         name: tuple["todo_name"],
                         completed: is_complete(tuple)}
  end

  def query(statement, *params)
    @logger.info("#{statement}: #{params}")
    @db.exec_params(statement, params)
  end

end


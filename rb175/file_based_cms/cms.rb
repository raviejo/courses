require 'sinatra'
require 'sinatra/reloader'
require 'erubis'
require 'redcarpet'
require 'yaml'
require 'bcrypt'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  pattern = File.join(data_path, '*')
  @files = Dir.glob(pattern).map { |file_path| File.basename(file_path) }.sort
end

helpers do
  def signed_in?
    session[:username]
  end
end

# Show the form to create a new document
get '/create' do
  redirect_not_signed_in unless signed_in?

  erb :create
end

# Show the homepage with all of the files
get '/' do
  erb :index
end

# Sign in page
get '/users/signin' do
  erb :sign_in
end

# Show the contents of file
get '/:file_name' do
  redirect_not_signed_in unless signed_in?

  file_path = File.join(data_path, File.basename(params[:file_name]))

  redirect_not_a_file unless File.file?(file_path)
  load_file_content(file_path)
end

# Edit the contents of a file
get '/:file_name/edit' do
  redirect_not_signed_in unless signed_in?

  file_path = File.join(data_path, params[:file_name])

  redirect_not_a_file unless File.file?(file_path)
  @content = File.read(file_path)

  erb :edit_file
end

# Create a new document
post '/create' do
  redirect_not_signed_in unless signed_in?

  file_name = params[:file_name].to_s

  if file_name == ""
    status 422
    session[:message] = "A name is required."
    erb :create
  elsif File.extname(file_name) == ""
    status 422
    session[:message] = "A valid extension name needs to be provided."
    erb :create
  else
    File.new(File.join(data_path, file_name), "w")
    session[:message] = "#{params[:file_name]} was created."
    redirect '/'
  end
end

# Attempt to log in
post '/users/signin' do
  username = params[:username]
  password = params[:password]

  if valid_credentials?(username, password)
    session[:username] = username
    session[:message] = 'Welcome!'
    redirect '/'
  else
    status 422
    session[:message] = 'Invalid Credentials'
    erb :sign_in
  end
end

# Sign out a signed in user
post '/users/signout' do
  session[:message] = 'You have been signed out.'
  session.delete(:username)
  redirect '/'
end

# Write changes onto the file
post '/:file_name/edit' do
  redirect_not_signed_in unless signed_in?

  file_path = File.join(data_path, params[:file_name])

  File.write(file_path, params[:content])

  session[:message] = "#{params[:file_name]} has been updated."
  redirect '/'
end

post '/:file_name/destroy' do
  redirect_not_signed_in unless signed_in?

  file_path = File.join(data_path, params[:file_name])

  File.delete(file_path)

  session[:message] = "#{params[:file_name]} has been deleted."
  redirect '/'
end

def data_path
  if ENV['RACK_ENV'] == 'test'
    File.expand_path('../test/data', __FILE__)
  else
    File.expand_path('../data', __FILE__)
  end
end

def redirect_not_a_file
  session[:message] = "#{params[:file_name]} does not exist."
  redirect '/'
end

def render_markdown(md)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(md)
end

def load_file_content(file_path)
  content = File.read(file_path)
  case File.extname(file_path)
  when '.txt'
    headers['Content-Type'] = 'text/plain'
    content
  when '.md'
    render_markdown(content)
  end
end

def valid_credentials?(username, password)
  users.key?(username) && BCrypt::Password.new(users[username]) == password
  # username == 'admin' && password == 'secret'
end

def redirect_not_signed_in
  session[:message] = 'You must be signed in to do that.'
  redirect '/'
end

def signed_in?
  session.key?(:username)
end

def credentials_path
  if ENV['RACK_ENV'] == 'test'
    File.expand_path('../test/users.yml', __FILE__)
  else
    File.expand_path('../users.yml', __FILE__)
  end
end

def users
  YAML.load_file(credentials_path)
end
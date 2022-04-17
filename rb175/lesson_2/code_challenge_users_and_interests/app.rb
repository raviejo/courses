require 'sinatra'
require 'sinatra/reloader'
require 'erubis'
require 'yaml'

before do
  @users = YAML.load_file('data/users.yaml')
end

helpers do
  def count_interests
    @users.map { |_, info| info[:interests] }.flatten.uniq.count
  end
end

get '/' do
  erb :home
end

get '/localhost.com/books' do
  "hello"
end

get '/users/:name' do
  @user = params['name'].intern
  erb :user
end
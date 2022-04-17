require 'sinatra'
require 'sinatra/reloader'
require 'bcrypt'
require 'erubis'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

get '/' do
  erb :retro
end

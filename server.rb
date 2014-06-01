require_relative 'server_methods'
require 'sinatra'

get '/' do
  redirect :recipes
end


get '/recipes' do
  @recipes = get_recipes
  erb :recipes
end


get '/recipes/:id' do

end


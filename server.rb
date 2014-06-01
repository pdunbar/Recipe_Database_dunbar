require_relative 'server_methods'
require 'sinatra'

get '/' do
  redirect '/recipes'
end


get '/recipes' do
  @recipes = get_recipes
  erb :recipes
end


get '/recipes/:id' do
  @recipe_id = params[:id]
  @recipe, @ingredients = get_recipe(@recipe_id)

  erb :recipe
end


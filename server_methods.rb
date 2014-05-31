require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end

def get_recipes()
  query = ""

  recipes = db_connection do |conn|
    conn.exec(query)
  end

  recipes = recipeses.to_a
  return recipes
end


def get_recipe(recipe_id)
  query =
  ingredients = db_connection do |conn|
    conn.exec_params(query, [recipe_id])
  end

  query = ""
  recipes = db_connection do |conn|
    conn.exec_params(query, [recipe_id])
  end
  recipe = recipe.to_a
  ingredients = ingredients.to_a
  return recipe, ingredients
end

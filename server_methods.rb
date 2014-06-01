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
  query = "SELECT recipes.id as id, recipes.name as name
           FROM recipes"

  recipes = db_connection do |conn|
    conn.exec(query)
  end

  recipes = recipes.to_a
  recipes = recipes.sort_by do |recipe|
    recipe["name"]
  end
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

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
  query = "SELECT recipes.id as recipe_id, recipes.name as name
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
  query = " SELECT recipes.id, recipes.name as name,
            recipes.instructions as instructions, recipes.description as description
            FROM recipes
            WHERE recipes.id = $1"
  recipe = db_connection do |conn|
    conn.exec_params(query, [recipe_id])
  end

  query = "SELECT ingredients.name as ingredient
           FROM recipes
           JOIN ingredients on ingredients.recipe_id = recipes.id
           WHERE recipes.id = $1"

  ingredients = db_connection do |conn|
    conn.exec_params(query, [recipe_id])
  end
  recipe = recipe.to_a
  ingredients = ingredients.to_a
  return recipe, ingredients
end

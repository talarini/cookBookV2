class RecipesController < ApplicationController
  def show
    @recipes = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

   def create
    @recipe = Recipe.create(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine_id, :difficulty, :cook_time, :ingredients, :method, :portion)
  end
end

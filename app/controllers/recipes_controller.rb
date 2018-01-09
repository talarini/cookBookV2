class RecipesController < ApplicationController
  def show
    @recipes = Recipe.find(params[:id])
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all

    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render 'new'
    end
  end

  def search
    @recipe_search = params[:search]
    @recipes = Recipe.where "title like ?", "%#{@recipe_search}%"

  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
  end

end

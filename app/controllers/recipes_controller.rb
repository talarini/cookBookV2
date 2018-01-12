class RecipesController < ApplicationController

  before_action :get_recipes, only: [:edit, :update, :destroy]
  before_action :get_params, only: [:show, :create, :update, :new]

  def show
    @recipes = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def search
    @recipes = Recipe.where "title like ?", params[:search]
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients, :method)
  end

  def get_recipes
    @recipe = Recipe.find(params[:id])
  end

  def get_params
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end

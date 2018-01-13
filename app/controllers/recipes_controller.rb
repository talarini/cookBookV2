class RecipesController < ApplicationController

  before_action :get_recipes, only: [:edit, :update, :destroy, :show]
  before_action :get_params, only: [:show, :create, :update, :new]
  before_action :authenticate_user! , only: [:edit]

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe.user_id = current_user.id if current_user
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
    if @recipe.user_id == current_user.id
      @recipe.update(recipe_params)
      if @recipe.save
        redirect_to recipe_path(@recipe)
      else
        flash.now[:alert] = 'Você deve informar todos os dados da receita'
        render :new
      end
    else
      flash.now[:alert] = 'Operação NEGADA - Voce não é dono desta receita'
      render :new
    end
  end

  def search
    @search = params[:search]
    @recipes = Recipe.where("title LIKE ? or ingredients LIKE ?", "%#{@search}%" ,"%#{@search}%" )
    flash.now[:alert] = 'Nenhuma receita encontrada' unless @recipes.any?
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
      :difficulty, :cook_time, :ingredients, :method, :user)
    end

    def get_recipes
      @recipe = Recipe.find(params[:id])
    end

    def get_params
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
    end
  end

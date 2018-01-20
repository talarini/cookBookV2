class RecipesController < ApplicationController

  before_action :get_recipes, only: [:edit, :update, :destroy, :show , :favorite, :destroy_favorite, :share]
  before_action :get_types, only: [:show, :create, :update, :new]
  before_action :authenticate_user! , only: [:edit,:favorites, :create]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = 'Receita cadastrada com sucesso'
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    if current_user.my_recipe? @recipe
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
    else
      redirect_to root_path
    end
  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      flash[:notice] = 'Receita atualizada com sucesso'
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def search
    @search = params[:search]
    @recipes = Recipe.where("title LIKE ? or ingredients LIKE ?", "%#{@search}%" ,"%#{@search}%" )
    flash.now[:error] = 'Nenhuma receita encontrada' unless @recipes.any?
  end

  def destroy
    if @recipe.destroy
      flash[:notice] = 'Receita removida com sucesso'
      redirect_to root_path
    else
      flash[:error] = 'Algo deu errado, tente novamente'
      redirect_to root_path
    end
  end

  def favorite
    @favorite = Favorite.new(user: current_user, recipe: @recipe)
    if @favorite.save
      flash.now[:notice] = 'Receita favoritada com sucesso'
      render :show
    else
      flash.now[:error] = 'Erro ao favoritar a receita'
      render :show
    end
  end

  def favorites
    @favorites = Favorite.where(user: current_user)
  end

  def destroy_favorite
    @favorite = Favorite.find_by(user: current_user, recipe: @recipe)
    if @favorite.destroy
      flash[:notice] = 'Receita removida dos favoritos'
      redirect_to @recipe
    else
      flash.now[:error] = 'Algo deu errado, tente novamente'
      render :show
    end
  end

  def share
    email = params[:email]
    msg = params[:message]

    RecipesMailer.share(email,msg,@recipe.id).deliver_now
    flash[:notice] = "Receita compartilhada com #{email}"
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
      :difficulty, :cook_time, :ingredients, :method, :user, :image, :featured)
    end

    def get_recipes
      @recipe = Recipe.find(params[:id])
    end

    def get_types
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
    end
  end

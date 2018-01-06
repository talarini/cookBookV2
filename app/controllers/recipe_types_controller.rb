class RecipeTypesController <ApplicationController

  def show
    @recipe_types = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type_id: params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.create(recipe_types_params)
  end

  private

  def recipe_params
    params.require(:recipe_type).permit(:name)
  end



end

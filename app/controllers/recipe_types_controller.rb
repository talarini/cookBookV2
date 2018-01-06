class RecipeType <ApplicationController
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

class RecipeTypesController <ApplicationController

  def show
    @recipe_types = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type_id: params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.create(recipe_type_params)
    if @recipe_type.save
      redirect_to recipe_type_path(@recipe_type)
    else
      flash.now[:alert] = 'Você deve informar o nome do tipo de receita'
      render 'new'
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end

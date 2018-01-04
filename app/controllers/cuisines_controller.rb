class CuisinesController <ApplicationController
  def show
    @cuisines = Cuisine.find(params[:id])
    @recipes = Recipe.where(cuisine_id: params[:id])
  end
end

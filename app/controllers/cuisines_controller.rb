class CuisinesController <ApplicationController
  def show
    @cuisines = Cuisine.find(params[:id])
    @recipes = Recipe.where(cuisine_id: params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.create(cuisine_params)
    if @cuisine.save
      redirect_to cuisine_path(@cuisine)
    else
      render '_error'
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

end

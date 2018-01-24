class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.create(cuisine_params)
    if @cuisine.save
      flash[:success] = 'Cozinha cadastrada com sucesso'
      redirect_to @cuisine
    else
      flash.now[:alert] = 'Você deve informar o nome da cozinha'
      render :new
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end

class FavouritesController < ApplicationController
  
  before_action :set_task, only: [:create, :destroy]
  before_action :set_neighbourhood

  def index
    @favourites = Favourite.all
  end

  def create

    # @toggle_favourite = favourite! 
    




    @service.favourite!
    @favourite.user = current_user
    @service.neighbourhood = @neighbourhood

    redirect_to neighbourhood_service_path(@neighbourhood, @service)


    if @toggle_favourite
      redirect_to neighbourhood_service_path(@neighbourhood, @service)
    else
      render :new
    end


  end

  def destroy
    @service.unfavourite!
    redirect_to neighbourhood_service_path(@neighbourhood, @service)
  end

  # private

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end
end

  # def new
  #   @favourite = Favourite.new
  # end

  # def create
  #   @service = Service.find(params[:service_id])
  #   @favourite = Favourite.new(favourite_params)
  #   @favourite.service = @service
  #   @favourite.user = current_user
  #   if @favourite.save
  #     redirect_to neighbourhood_service_path(@service)
  #   else
  #     render 'services/show'
  #   end
  # end

  # def destroy
  #   @favourite = Favourite.find(params[:id])
  #   @favourite.destroy
  #   redirect_to neighbourhood_service_path(@service.service)
  # end

  # private

  # def favourite_params
  #   params.permit(:service_id)
  # end
# end
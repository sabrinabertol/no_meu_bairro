class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
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
  #     redirect_to service_path(@service)
  #   else
  #     render 'services/show'
  #   end
  # end

  # def destroy
  #   @favourite = Favourite.find(params[:id])
  #   @favourite.destroy
  #   redirect_to service_path(@service.service)
  # end

  # private

  # def favourite_params
  #   params.permit(:service_id)
  # end
end

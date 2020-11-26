class NeighbourhoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false

  def index
    if params[:neighbourhood].present?
      @neighbourhoods = Neighbourhood.all.order(name: :asc)
      @neighbourhood = Neighbourhood.find(params[:neighbourhood][:id])
      redirect_to neighbourhood_path(@neighbourhood)
    end
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])
    
    @services = @neighbourhood.services

    @pagy, @services = pagy(@services, items: 4) 

    @markers = @services.geocoded.map do |service|
      {
        lat: service.latitude,
        lng: service.longitude,
        infoWindow:render_to_string(partial: "info_window", locals: { service: service }),
        image_url: helpers.asset_url('location.png')
      }
    end
  end
end

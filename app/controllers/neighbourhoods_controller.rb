class NeighbourhoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false

  def index
    @neighbourhoods = Neighbourhood.all
    @neighbourhood = Neighbourhood.new
    @neighbourhoods_names = @neighbourhoods.pluck(:name)
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])

    @services = @neighbourhood.services
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

class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false
  before_action :set_neighbourhood, except: [:destroy]
  before_action :set_service, only: [:show, :update, :edit, :destroy, :favourite, :unfavourite]

  def index
    @services = Service.all
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
     @markers = @services.geocoded.map do |service|
      {
        lat: service.latitude,
        lng: service.longitude,
        infoWindow:render_to_string(partial: "info_window", locals: { service: service }),
        image_url: helpers.asset_url('location.png')
       }
    end
  end

  def show
    @favourite = Favourite.new
    @review = Review.new
    # @markers =
    #   [{
    #     lat: @service.latitude,
    #     lng: @service.longitude
    #   }]
  end

  def new
    @service = Service.new
  end

  def create
    @service.user = current_user
    if @service.save
      redirect_to neighbourhood_service_path(@service), notice: "The service #{@service.name} was created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @service.update(service_params)
    @service.save
    redirect_to neighbourhood_service_path(@service.id)
  end

  def destroy
    @service.destroy
    redirect_to neighbourhood_services_path
  end

  private

  def service_params
    params.require(:service).permit(
      :name, :neighbourhood_id, :user_id, :address, :phone, :time, :socialmedia, :latitude, :longitude, photos: []
    )
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end
end

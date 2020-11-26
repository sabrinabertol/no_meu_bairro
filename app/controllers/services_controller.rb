class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false
  before_action :set_neighbourhood
  before_action :set_service, only: [:show, :update, :edit, :destroy, :fav, :unfav]
  include Pagy::Backend

  def index
    if params[:query].present?
      @services = Service.where(neighbourhood:@neighbourhood).search_by_name_and_category(params[:query])
      @markers = @services.geocoded.map do |service|
        {
          lat: service.latitude,
          lng: service.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { service: service }),
          image_url: helpers.asset_url('location.png')
        }
      end
    else
      @services = Service.all
      

      @markers = @services.geocoded.map do |service|
        {
          lat: service.latitude,
          lng: service.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { service: service }),
          image_url: helpers.asset_url('location.png')
        }
      end
    end

    @favourites = Favourite.all
    


  end

  def show
    @service.neighbourhood = @neighbourhood
    @review = Review.new
    @markers =
      [{
        lat: @service.latitude,
        lng: @service.longitude,
        image_url: helpers.asset_url('location.png')
      }]
  end

  def new
    @service = Service.new
    @service.neighbourhood = @neighbourhood
  end

  def create
    @service = Service.new(service_params)
    @service.neighbourhood = @neighbourhood
    @service.user = current_user
    if @service.save
      redirect_to neighbourhood_service_path(@neighbourhood, @service), notice: "<strong>#{@service.name}</strong> was created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @service.neighbourhood = @neighbourhood
    @service.update(service_params)
    @service.save
    redirect_to neighbourhood_service_path(@neighbourhood, @service)
  end

  def destroy
    @service.destroy
    redirect_to neighbourhood_services_path
  end

  def fav
    @favourite = Favourite.create(user: current_user, service: @service)
    redirect_to neighbourhood_service_path(@neighbourhood, @service)
  end

  def unfav
    @favourite = Favourite.find_by(user: current_user, service: @service)
    @favourite.destroy

    redirect_to neighbourhood_service_path(@neighbourhood, @service)
  end

  private

  def service_params
    params.require(:service).permit(
      :name, :address, :phone, :opentime, :closetime, :category, :latitude,
      :longitude, :website, :weekdays, :description, :favourite, photos: []
    )
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end
end

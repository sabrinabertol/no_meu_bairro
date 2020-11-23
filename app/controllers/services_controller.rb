class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false
  before_action :set_neighbourhood
  before_action :set_service, only: [:show, :update, :edit, :destroy, :favourite!, :unfavourite!]

  def index
    if params[:query].present?
      @services = Service.search_by_name_and_category(params[:query])
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
  end

  def show
    @service.neighbourhood = @neighbourhood
    # @favourite = Favourite.new
    @review = Review.new
    @markers =
      [{
        lat: @service.latitude,
        lng: @service.longitude
      }]
  end

  def new
    @service = Service.new
    @service.neighbourhood = @neighbourhood
  end

  def create
    @service.neighbourhood = @neighbourhood
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to neighbourhood_service_path(@neighbourhood, @service), notice: "The service #{@service.name} was created successfully!"
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

  def favourite!
    @service.neighbourhood = @neighbourhood
    @neighbourhood.service.favourite = true
    @service.save!
  end

  def unfavourite!
    @service.neighbourhood = @neighbourhood
    @neighbourhood.service.favourite = false
    @service.save!
  end

  private

  def service_params
    @service.neighbourhood = @neighbourhood
    params.require(:service).permit(
      :name, :address, :phone, :opentime, :closetime, :category, :latitude,
      :longitude, :photo, :website, :weekdays, :description, :favourite
    )
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end
end

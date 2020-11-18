class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false
  before_action :set_neighbourhood
  before_action :set_service, only: [:show, :update, :edit, :destroy]

  def index
    if params[:query].present?
      
        # sql_query = " \ Postgres multiple search
        # movies.title @@ :query \
        # OR movies.syllabus @@ :query \
        # OR directors.first_name @@ :query \
        # OR directors.last_name @@ :query \
      # "
      # sql_query = " \  Multiple search + Association search
      #   movies.title ILIKE :query \
      #   OR movies.syllabus ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      #sql_query = "title ILIKE :query OR syllabus ILIKE :query" multiple seach in syllabus and title
      #@movies = Movie.where(title: params[:query]) exact match
      #@movies = Movie.where("title ILIKE ?", "%#{params[:query]}") exact match but case insensitive
      #@movies = Movie.where(sql_query, query:  "%#{params[:query]}%" ) multiple seach in syllabus and title
      # @movies = Movie.joins(:director).where(sql_query, query:  "%#{params[:query]}%" )
      @services = Service.search_by_name(params[:query])
      # @movies = Movie.global_search(params[:query])
      # @results = PgSearch.multisearch(params[:query]) carefull with this one!

    else
      @services = Service.all
    end
    
    # @markers = @services.geocoded.map do |service|
    #   {
        # lat: service.latitude,
    #     lng: service.longitude,
    #     infoWindow:render_to_string(partial: "info_window", locals: { service: service }),
    #     image_url: helpers.asset_url('???')
    #   }
    # end
  end

  def show
    @service.neighbourhood = @neighbourhood
    # @favourite = Favourite.new
    # @review = Review.new
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
    @service = Service.new(service_params)
    @service.user = current_user
    @service.neighbourhood = @neighbourhood
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

  private

  def service_params
    params.require(:service).permit(
      :name, :address, :phone, :opentime, :closetime, :category, :latitude, :longitude, :photo, :website, :weekdays
    )
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end
end

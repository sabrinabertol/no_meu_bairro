class ReviewsController < ApplicationController
  before_action :set_service, :set_neighbourhood

  def new
    @review = Review.new
  end

  def create
      @review = Review.new(review_params)
      @review.service = @service
      @review.user = current_user
      if @review.save
        redirect_to neighbourhood_service_path(@neighbourhood, @service), notice: 'your review was created!'
      else
        redirect_to neighbourhood_services_path(@neighbourhood, @service), notice: 'something went wrong!'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

   def set_service
    @service = Service.find(params[:service_id])
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end
end


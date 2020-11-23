class NewsController < ApplicationController
  before_action :set_neighbourhood

  def index
    @news = NewsService.call
  end

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end
end

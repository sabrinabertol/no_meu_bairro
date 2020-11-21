class NewsController < ApplicationController
  before_action :set_neighbourhood

  def new
    @news = New.new
  end

  def create
      @new= New.new(news_params)
      @new.neighbourhood = @neighbourhood
      @new.save
  end

  private

  def news_params
    params.require(:new).permit(:url, :title, :content)

  def set_neighbourhood
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end
end

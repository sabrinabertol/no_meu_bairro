class NewsController < ApplicationController
  def index
    @news = NewsService.call
  end
  
end

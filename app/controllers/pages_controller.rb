class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home, :about ]
  before_action :authenticate_user!

  def home
  end

  def about
  end

  def dashboard
    @news = NewsService.call
    @neighbourhood = current_user.neighbourhood
    @favourites = current_user.favourites
    @posts = Post.all
  end

  def favourites
    @favourites = current_user.favourites
    @neighbourhood = current_user.neighbourhood
  end

end

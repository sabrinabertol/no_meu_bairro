class NeighbourhoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false

  def index
    if params[:neighbourhood].present?
    @neighbourhoods = Neighbourhood.all.order(name: :asc)
      @neighbourhood = Neighbourhood.find(params[:neighbourhood][:id])
      redirect_to neighbourhood_path(@neighbourhood)
    end
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])
  end
end

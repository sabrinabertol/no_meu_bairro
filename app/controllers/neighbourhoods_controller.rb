class NeighbourhoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false

  def index
    @neighbourhoods = Neighbourhood.all
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])
  end
end

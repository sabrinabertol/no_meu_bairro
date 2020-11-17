class NeighbourhoodsController < ApplicationController
  def index
    @neighbourhood = Neighbourhood.all
  end
end

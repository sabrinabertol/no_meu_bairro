class NeighbourhoodsController < ApplicationController
  def index
     @neighbourhoods = Neighbourhood.all
  end
end

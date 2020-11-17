class UsersController < ApplicationController
  has_one_attached :photo
  # acts_as_favoritor
  def article_params
    params.require(:user).permit(:name, :email, :password, :neighbourhood_id, :photo)
  end
end

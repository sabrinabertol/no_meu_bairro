class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def default_url_options
    { host: ENV["nomeubairro.eu"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :photo, :neighbourhood_id])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :service_owner, :photo, :neighbourhood_id])

  end
end

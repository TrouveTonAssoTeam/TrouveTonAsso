class AssociationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def show
      @association = Association.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :city, :website])
  end
 
end
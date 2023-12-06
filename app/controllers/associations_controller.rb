require 'net/http'
require 'uri'
require 'json'

class AssociationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def test
    
  end

  def new
    uri = URI.parse("https://siva-integ1.cegedim.cloud/apim/api-asso/api/structure/#{params[:id]}")
    response = Net::HTTP.get_response(uri)

    data_hash = JSON.parse(response.body)
    puts "data_hash : "
    puts data_hash

    if data_hash["erreur"] != nil
      flash.now[:alert] = "Error : #{data_hash["erreur"]}"
    end
  end

  def show
      @association = Association.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :city, :website])
  end
 
end
require 'net/http'
require 'uri'
require 'json'

class AssociationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_already_verified?

  def test
    
  end

  def new
    uri = URI.parse("https://siva-integ1.cegedim.cloud/apim/api-asso/api/structure/#{params[:id]}")
    response = Net::HTTP.get_response(uri)

    data_hash = JSON.parse(response.body)

    if data_hash["erreur"] != nil || data_hash["identite"]["active"] == false || Association.find_by(rna: data_hash["id_rna"]).present?
      flash[:alert] = "Le numéro renseigné n'est pas valable"
      redirect_to association_test_path
    else
      @asso = Hash.new
      @asso["name"] = data_hash["identite"]["nom"]
      @asso["description"] = data_hash["activites"]["objet"]
      @asso["address"] = data_hash["coordonnees"]["adresse_siege"]["num_voie"].to_s + " " + data_hash["coordonnees"]["adresse_siege"]["type_voie"] + " " + data_hash["coordonnees"]["adresse_siege"]["voie"]
      @asso["city"] = data_hash["coordonnees"]["adresse_siege"]["commune"]
      @asso["zip"] = data_hash["coordonnees"]["adresse_siege"]["cp"]
      @asso["RNA"] = data_hash["id_rna"]
      session[:asso] = @asso

      redirect_to new_association_registration_path
    end
  end

  def show
      @association = Association.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
    [:name, :description, :city, :address, :zip])
  end
 
  def is_already_verified?
    if session[:asso]
      redirect_to new_association_registration_path
    end
  end
end
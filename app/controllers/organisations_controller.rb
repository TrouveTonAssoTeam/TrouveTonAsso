require 'net/http'
require 'uri'
require 'json'

class OrganisationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_already_verified?, only: [:test]
  before_action :authenticate_organisation!, only: [:dashboard, :edit, :update, :delete]

  def test
    
  end

  def new
    uri = URI.parse("https://siva-integ1.cegedim.cloud/apim/api-asso/api/structure/#{params[:id]}")
    response = Net::HTTP.get_response(uri)

    data_hash = JSON.parse(response.body)

    if data_hash["erreur"] != nil || data_hash["identite"]["active"] == false || Organisation.find_by(rna: data_hash["id_rna"]).present?
      flash[:alert] = "Le numéro renseigné n'est pas valable"
      redirect_to test_organisations_path
    else
      @asso = Hash.new
      @asso["name"] = data_hash["identite"]["nom"]
      @asso["description"] = data_hash["activites"]["objet"]
      @asso["address"] = data_hash["coordonnees"]["adresse_siege"]["num_voie"].to_s + " " + data_hash["coordonnees"]["adresse_siege"]["type_voie"] + " " + data_hash["coordonnees"]["adresse_siege"]["voie"]
      @asso["city"] = data_hash["coordonnees"]["adresse_siege"]["commune"]
      @asso["zip"] = data_hash["coordonnees"]["adresse_siege"]["cp"]
      @asso["RNA"] = data_hash["id_rna"]
      session[:asso] = @asso

      redirect_to new_organisation_registration_path
    end
  end

  def show
      @organisation = Organisation.find(params[:id])
      @faqs = @organisation.faqs
  end

  def delete
    @organisation = Organisation.find(params[:id]) 
  end 

  def index
    @organisations = Organisation.all
  end

  def edit
    @organisation = Organisation.find(params[:id])
    if @organisation == current_organisation
    else
      redirect_to new_organisation_session_path, alert: "Vous devez vous connecter pour accéder à cette page."
    end
  end

  def update
    @organisation = Organisation.find(params[:id])

    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to @organisation, notice: 'Association was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  def dashboard
    @organisation = current_organisation
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
    [:name, :description, :city, :address, :zip])
  end
 
  def is_already_verified?
    if session[:asso]
      redirect_to new_organisation_registration_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :city])
  end

  def organisation_params
    params.require(:organisation).permit(:name, :description, :city, :cover_photo)
  end

end

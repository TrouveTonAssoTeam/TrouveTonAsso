require 'net/http'
require 'uri'
require 'json'

class AssociationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_association!, only: [:show]
  before_action :find_association, only: [:show]

  def delete
    association = Association.find(params[:id])
  end 

  def find_association
    @association = Association.find(params[:id])
  end

  def index
    @associations = Association.all
  end

  def test
    # Votre action test
  end

  def new
    uri = URI.parse("https://siva-integ1.cegedim.cloud/apim/api-asso/api/structure/#{params[:id]}")
    response = Net::HTTP.get_response(uri)

    data_hash = JSON.parse(response.body)
    puts "data_hash : "
    puts data_hash

    if data_hash["erreur"].present?
      flash.now[:alert] = "Error : #{data_hash["erreur"]}"
    end
  end

  def show_association
    @association = Association.find(params[:id])
  end

  def edit
    @association = Association.find(params[:id])
    if @association == current_association
      # Afficher le formulaire de modification de la page d'accueil
    else
      redirect_to new_association_session_path, alert: "Vous devez vous connecter pour accéder à cette page."
    end
  end

  def update
    @association = Association.find(params[:id])

    respond_to do |format|
      if @association.update(association_params)
        format.html { redirect_to @association, notice: 'Association was successfully updated.' }
        format.json { render :show, status: :ok, location: @association }
      else
        format.html { render :edit }
        format.json { render json: @association.errors, status: :unprocessable_entity }
      end
    end
  end

  def dashboard
    @association = current_association
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :city, :website])
  end

  def association_params
    params.require(:association).permit(:name, :description, :city, :website, :cover_photo)
  end
end





require "uri"
require "net/http"
# frozen_string_literal: true

class Organisations::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :is_association?
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super

    asso = Organisation.find_by(email: params[:organisation][:email])
    asso.update(name: session[:asso]["name"], description: session[:asso]["description"], city: session[:asso]["city"], address: session[:asso]["address"], zip: session[:asso]["zip"], rna: session[:asso]["RNA"])

    session[:asso] = nil
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :city, :address, :zip])
  end

  # Redirect to check if asso is valid or note
  def is_association?
    flash[:alert] = "Vous devez renseigner un numéro d'association avant de continuer" unless session[:asso]
    redirect_to organisation_test_path unless session[:asso]
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

class ProfilController < ApplicationController
  before_action :authenticate_user!

    def show
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user

        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]
        @user.address = params[:user][:address]


        if @user.save
            redirect_to profil_path
            notice = "Votre profile a bien été mis à jour."
        else 
            render :edit
        end
    end
end
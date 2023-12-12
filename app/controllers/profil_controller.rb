class ProfilController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:edit, :update]

    def index
        @user = current_user
        @donations = @user.donations
        @likes = @user.likes.map(&:organisation)
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user

        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]


        if @user.save
            redirect_to profil_index_path
            notice = "Votre profile a bien été mis à jour."
        else 
            render :edit
        end
    end
end
class ProfilController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:edit, :update]

  def show
    @user = current_user
    @liked_organisations = @user.likes.includes(:organisation).map(&:organisation)
  end 
  
    def index
        @user = current_user
        @donations = @user.donations.order(created_at: :desc)
        @likes = @user.likes.map(&:organisation)
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user

        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]

        if params[:user][:avatar]
            @user.avatar.attach(params[:user][:avatar])
        end

        if @user.save
            redirect_to profil_index_path
            notice = "Votre profile a bien été mis à jour."
        else 
            render :edit
        end
    end
end
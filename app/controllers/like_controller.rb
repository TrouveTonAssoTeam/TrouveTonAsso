class LikeController < ApplicationController
    before_action :authenticate_user!
    before_action :is_correct_user?, only: [:user_likes]
     
    def index 
        @organisation = Organisation.find(1)
    end

    def like
        @organisation = Organisation.find(params[:organisation_id])
        Like.create(user: current_user, organisation: @organisation)
        redirect_back(fallback_location: root_path)
    end

    def unlike
        @organisation = Organisation.find(params[:organisation_id])
        Like.where(user: current_user, organisation: @organisation).destroy_all
        redirect_back(fallback_location: root_path)
    end

    def user_likes
        @organisations = current_user.likes.map(&:organisation)
    end

end


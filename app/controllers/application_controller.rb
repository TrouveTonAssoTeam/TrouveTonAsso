class ApplicationController < ActionController::Base
    def set_dyslexie
        cookies[:dyslexie] = params[:value]
        redirect_back fallback_location: root_path
    end
end

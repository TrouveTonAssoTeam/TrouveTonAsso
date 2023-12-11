class FaqsController < ApplicationController
    before_action :authenticate_user!
    def new
        @organisation = Organisation.find(params[:organisation_id])
    end

    def create
        @faq = Faq.new
        @faq.organisation = Organisation.find(params[:organisation_id])
        @faq.user = current_user
        @faq.question = params[:question]

        if @faq.save
            redirect_to organisation_path(params[:organisation_id]), notice: "Votre question a bien été envoyée."
        else 
            redirect_to organisation_path(params[:organisation_id]), alert: "Une erreur est survenue. Merci de contacter le support pour plus d'informations."
        end
    end
end

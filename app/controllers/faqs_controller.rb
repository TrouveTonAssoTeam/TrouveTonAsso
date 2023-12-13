class FaqsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :pending_question?, only: [:new, :create]
    before_action :authenticate_organisation! && :is_organisation_owner?, only: [:new_answer, :create_answer]
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

    def new_answer
        @faq = Faq.find(params[:faq_id])
    end

    def create_answer
        @faq = Faq.find(params[:faq_id])

        @faq.answer = params[:faq][:answer]

        if @faq.save
            redirect_to dashboard_organisations_path, notice: "Votre reponse a bien été envoyée."
        else
            redirect_to answer_faq_organisations_path, alert: "Une erreur est survenue. Merci de réessayer."
        end
    end

    private

    def pending_question?
        if !Faq.where(user: current_user).where(organisation_id: params[:organisation_id]).where(answer: nil).empty?
            flash.alert = "Vous avez déjà une question en attente de réponse. Merci de patienter le temps que l'association puisse vous répondre." 
            redirect_back fallback_location: root_path
        end
    end

    def is_organisation_owner?
        redirect_back fallback_location: root_path unless current_organisation == Faq.find(params[:faq_id]).organisation
    end
end

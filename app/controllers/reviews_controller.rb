class ReviewsController < ApplicationController
   
    def new
      @review = Review.new
    end
  

    def create
      @review = Review.new(review_params)
      if @review.save
        redirect_to @review, notice: "L'avis a été créé avec succès."
      else
        render :new
      end
    end
    
    private

    def review_params
      params.require(:review).permit(:title, :description, :rating, :event_id, :user_id)
    end
  end
  
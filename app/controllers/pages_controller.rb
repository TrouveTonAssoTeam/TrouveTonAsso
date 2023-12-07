class PagesController < ApplicationController
  def index
    flash.now[:notice] = "Welcome to Rails!"
    flash.now[:alert] = "This is an alert!"
  end
  def about
end
def contact
end

	def index
		@liked_associations = Association.joins(:liking_users).distinct
	end
end

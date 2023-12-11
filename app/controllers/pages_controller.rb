class PagesController < ApplicationController
  def index
  end
  
  def about
end
def contact
end

	def index
		@liked_organisation = Organisation.joins(:liking_users).distinct
	end
end
 


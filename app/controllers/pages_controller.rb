class PagesController < ApplicationController
  def index
  end
  
  def about
end
def contact
end

	def index
		@liked_associations = Association.joins(:liking_users).distinct
	end
end

class PagesController < ApplicationController
  def index
    flash.now[:notice] = "Welcome to Rails!"
    flash.now[:alert] = "This is an alert!"
  end
  def about
end
def contact
end
end

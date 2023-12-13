class PagesController < ApplicationController
  def index
    @organisations = Organisation.all.order("RANDOM()")
    @events = Event.all.order("RANDOM()")
    @promoted = Promoted.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).order(end_date: :desc).map(&:organisation)
  end
  
  def about
  end

  def contact
  end

end
 


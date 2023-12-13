class TipsController < ApplicationController
  #before_action :authenticate_admin!

  def all_tips
    @all_tips = Tip.all.order(created_at: :desc)
  end
end
class DashboardOrganisationController < ApplicationController
  before_action :authenticate_organisation!

  def index
    @organisation = current_organisation
    @events = @organisation.events
  end
end
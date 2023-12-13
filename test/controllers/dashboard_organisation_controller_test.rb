require "test_helper"

class DashboardOrganisationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_organisation_index_url
    assert_response :success
  end
end

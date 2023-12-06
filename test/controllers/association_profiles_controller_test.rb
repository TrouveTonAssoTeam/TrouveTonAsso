require "test_helper"

class AssociationProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get association_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get association_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get association_profiles_update_url
    assert_response :success
  end
end

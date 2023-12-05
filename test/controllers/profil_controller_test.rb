require "test_helper"

class ProfilControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profil_show_url
    assert_response :success
  end
end

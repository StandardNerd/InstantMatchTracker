require "test_helper"

class Api::WatirControllerTest < ActionDispatch::IntegrationTest
  test "should get receive_data" do
    get api_watir_receive_data_url
    assert_response :success
  end
end

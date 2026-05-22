require "test_helper"

class SignInFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
  end

  test "sign in page renders" do
    get new_user_session_path
    assert_response :success
    assert_select "input[type=email]"
    assert_select "input[type=password]"
  end

  test "sign in with valid credentials redirects to root" do
    post user_session_path, params: { user: { email: @user.email, password: "password123" } }
    assert_redirected_to root_path
  end

  test "sign in with invalid credentials shows error" do
    post user_session_path, params: { user: { email: @user.email, password: "wrong" } }
    assert_response :unprocessable_entity
    assert_match /Invalid email or password/i, response.body
  end

  test "sign out destroys session" do
    sign_in @user
    delete destroy_user_session_path
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end
end

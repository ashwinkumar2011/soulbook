require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when not logged in" do
    sign_in users(:Ashwin)
    get :new
    assert_response :success
  end

 test "should render new page when logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
  
 test "should be logged in to post a status" do
    post :create, status: { content: "Hello" }
    assert_response :redirect
  end
  
  test "should create status when logged in" do
      sign_in users(:Ashwin)
      assert_difference('Status.count') do
      post :create, status: { content: @status.content }
      assert_redirected_to new_user_session_path
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status
    assert_response :success
  end
  
  test "should get edit when logged in" do
    sign_in users(:Ashwin)
    get :edit, id: @status
    assert_response :success
  end

 test "should redirect status update when not logged in" do
     
    put :update, id: @status, status: { content: @status.content } 
    assert_response :success
    assert_redirected_to new_user_session_path
  
  end

  test "should update status when logged in" do
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end

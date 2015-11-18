require 'test_helper'

class BootcampsControllerTest < ActionController::TestCase
  setup do
    @bootcamp = bootcamps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bootcamps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bootcamp" do
    assert_difference('Bootcamp.count') do
      post :create, bootcamp: { about: @bootcamp.about, accreditation: @bootcamp.accreditation, apprenticeship: @bootcamp.apprenticeship, email: @bootcamp.email, facebook: @bootcamp.facebook, housing: @bootcamp.housing, image: @bootcamp.image, job_assistance: @bootcamp.job_assistance, job_guarantee: @bootcamp.job_guarantee, location: @bootcamp.location, post_grad_resources: @bootcamp.post_grad_resources, speciality: @bootcamp.speciality, title: @bootcamp.title, twitter: @bootcamp.twitter, visa_assistance: @bootcamp.visa_assistance, website: @bootcamp.website }
    end

    assert_redirected_to bootcamp_path(assigns(:bootcamp))
  end

  test "should show bootcamp" do
    get :show, id: @bootcamp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bootcamp
    assert_response :success
  end

  test "should update bootcamp" do
    patch :update, id: @bootcamp, bootcamp: { about: @bootcamp.about, accreditation: @bootcamp.accreditation, apprenticeship: @bootcamp.apprenticeship, email: @bootcamp.email, facebook: @bootcamp.facebook, housing: @bootcamp.housing, image: @bootcamp.image, job_assistance: @bootcamp.job_assistance, job_guarantee: @bootcamp.job_guarantee, location: @bootcamp.location, post_grad_resources: @bootcamp.post_grad_resources, speciality: @bootcamp.speciality, title: @bootcamp.title, twitter: @bootcamp.twitter, visa_assistance: @bootcamp.visa_assistance, website: @bootcamp.website }
    assert_redirected_to bootcamp_path(assigns(:bootcamp))
  end

  test "should destroy bootcamp" do
    assert_difference('Bootcamp.count', -1) do
      delete :destroy, id: @bootcamp
    end

    assert_redirected_to bootcamps_path
  end
end

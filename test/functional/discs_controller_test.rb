require 'test_helper'

class DiscsControllerTest < ActionController::TestCase
  setup do
    @disc = discs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disc" do
    assert_difference('Disc.count') do
      post :create, disc: { artist_id: @disc.artist_id, catalog_number: @disc.catalog_number, label_id: @disc.label_id, release_year: @disc.release_year, sort_title: @disc.sort_title, title: @disc.title, toc: @disc.toc }
    end

    assert_redirected_to disc_path(assigns(:disc))
  end

  test "should show disc" do
    get :show, id: @disc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @disc
    assert_response :success
  end

  test "should update disc" do
    put :update, id: @disc, disc: { artist_id: @disc.artist_id, catalog_number: @disc.catalog_number, label_id: @disc.label_id, release_year: @disc.release_year, sort_title: @disc.sort_title, title: @disc.title, toc: @disc.toc }
    assert_redirected_to disc_path(assigns(:disc))
  end

  test "should destroy disc" do
    assert_difference('Disc.count', -1) do
      delete :destroy, id: @disc
    end

    assert_redirected_to discs_path
  end
end

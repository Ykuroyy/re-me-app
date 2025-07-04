require "test_helper"

class GoodMemoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get good_memories_index_url
    assert_response :success
  end

  test "should get show" do
    get good_memories_show_url
    assert_response :success
  end

  test "should get new" do
    get good_memories_new_url
    assert_response :success
  end

  test "should get create" do
    get good_memories_create_url
    assert_response :success
  end

  test "should get edit" do
    get good_memories_edit_url
    assert_response :success
  end

  test "should get update" do
    get good_memories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get good_memories_destroy_url
    assert_response :success
  end
end

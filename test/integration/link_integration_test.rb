require "test_helper"

class LinkIntegrationTest < ActionDispatch::IntegrationTest

  test "links index" do
    get links_path
    assert_response :ok
  end

  test "links index pagination" do
    get links_path(page: 2)
    assert_response :ok
  end

  test "links show" do
    get links_path(links(:anonymous))
    assert_response :ok
  end

  test "create link requires a url" do
    post links_path, params: { link: { url: "" } }
    assert_response :unprocessable_entity
  end

  test "create link as a guest" do
    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: { url: "https://rubygems.org" } }
      assert_response :ok
      assert_nil Link.last.user_id
    end
  end

  test "create link as user" do
    user = users(:one)
    sign_in(user)

    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: { url: "https://rubygems.org" } }
      assert_response :ok
      assert_equal user.id, Link.last.user_id
    end

    sign_out(user)
  end

  test "cannot edit links as a guest" do
    get edit_link_path(links(:anonymous))
    assert_response :redirect
  end

  test "cannot edit user's link as a guest" do
    get edit_link_path(links(:one))
    assert_response :redirect
  end

  test "can edit user's own link" do
    sign_in(users(:one))
    get edit_link_path(links(:one))
    assert_response :ok
  end

  test "cannot edit another user's link" do
    sign_in(users(:one))
    get edit_link_path(links(:two))
    assert_response :redirect
  end

  test "user cannot edit an anonymous link" do
    sign_in(users(:one))
    get edit_link_path(links(:anonymous))
    assert_response :redirect
  end

end

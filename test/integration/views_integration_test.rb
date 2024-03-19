require "test_helper"

class ViewsIntegrationTest < ActionDispatch::IntegrationTest

  test "visiting a link records a view" do
    link = links(:one)
    prev_view_count = link.views_count

    get view_path(link)
    updated_view_count = link.reload.views_count

    assert_equal prev_view_count + 1, updated_view_count
  end

  test "visiting a link redirects to the url" do
    link = links(:one)

    get view_path(link)
    assert_redirected_to link.url
  end

end

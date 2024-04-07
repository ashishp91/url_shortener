require 'rails_helper'

RSpec.describe "link features", type: :feature do

  it "creates links" do
    # visit links_url
    # within("#session") do
    #   fill_in 'Email', with: 'user@example.com'
    #   fill_in 'Password', with: 'password'
    # end
    # click_button 'Sign in'
    # expect(page).to have_content 'Success'
  end

  it "get links index page" do
    create(:ror_discuss_forum)
    create(:github_home_link)

    visit links_path
    binding.irb

    expect(page.all(:css, ".link-title").map(&:text).sort).to eq(Link.all.map(&:title))
  end
end

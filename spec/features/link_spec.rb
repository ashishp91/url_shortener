require 'rails_helper'

RSpec.describe "link features", type: :feature do

  before(:all) do
    DatabaseCleaner.clean
  end

  it "creates links" do
    visit links_path

    page.find(:id, 'link_url').fill_in(with: 'https://stackoverflow.com')
    page.find(:id, 'save_url').click

    expect(page.all(:css, ".link-title").map(&:text)[0]).to eq('https://stackoverflow.com')

    sleep 1
    visit current_path
    expect(page.all(:css, ".link-title").map(&:text)[0]).to include('Stack Overflow')
    expect(page.all(:css, ".link-description").map(&:text)[0]).to include('Stack Overflow')
  end

  it "get links index page" do
    create(:ror_discuss_forum)
    create(:github_home_link)

    visit links_path

    expect(page.all(:css, ".link-title").map(&:text).sort).to eq(Link.all.map(&:title).sort)
    expect(page.all(:css, ".link-description").map(&:text).sort).to eq(Link.all.map(&:description).sort)
  end

  it "shows links title, description and line chart on show page" do
    link = create(:ror_discuss_forum)

    visit links_path

    page.find(:css, ".show-link-#{link.id}-button").click

    link.reload
    expect(page.find(:css, ".link-url").text).to eq(link.url)
    expect(page.find(:css, ".link-description").text).to eq(link.description)
    expect(page.find(:css, ".link-line-chart")).not_to be_nil
  end

  it "can copy url from links index page" do
    link = create(:ror_discuss_forum)

    visit links_path

    page.find(:css, ".link-copy-#{link.id}")
    expect(page.find(:css, "[data-controller='clipboard']")['data-clipboard-text']).to include(view_path(link.to_param))
  end

  it "can copy url from links show page" do
    link = create(:ror_discuss_forum)

    visit links_path
    page.find(:css, ".show-link-#{link.id}-button").click

    page.find(:css, ".link-copy-#{link.id}")
    expect(page.find(:css, "[data-controller='clipboard']")['data-clipboard-text']).to include(view_path(link.to_param))
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end

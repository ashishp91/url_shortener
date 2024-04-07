require 'capybara/rspec'

driver_path = "./chromedriver/linux-123.0.6312.105/chromedriver-linux64/chromedriver"
path = "./chrome/linux-123.0.6312.105/chrome-linux64/chrome"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, driver_path: driver_path, path: path)
end

# set :selenium or :selenium_chrome or :selenium_chrome_headless
Capybara.default_driver = :selenium_chrome
Capybara.server = :puma

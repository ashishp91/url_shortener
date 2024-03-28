# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
View.destroy_all
Link.destroy_all

5.times do |ind|
  User.create!(
    email: "user#{ind}@example.com",
    password: 'password',
    password_confirmation: 'password',
  )
end

sample_urls = [
  'https://github.com/ashish91',
  'https://codingwithaglassofmilk.netlify.app/posts/rails/sessions-in-rails/',
  'https://codingwithaglassofmilk.netlify.app/posts/rails/concerns-in-rails/',
  'https://codingwithaglassofmilk.netlify.app/posts/design-patterns/builder-pattern/',
  'https://discuss.rubyonrails.org/',
  'https://discuss.rubyonrails.org/t/weird-behavior-with-date-and-timezone/85390',
  'https://discuss.rubyonrails.org/t/can-this-be-done-as-a-virtual-column/85374',
  'https://rubygems.org/',
  'https://tenderlovemaking.com/',
  'https://tenderlovemaking.com/2023/09/02/fast-tokenizers-with-stringscanner.html',
  'https://tenderlovemaking.com/2023/03/19/bitmap-matrix-and-undirected-graphs-in-ruby.html',
  'https://stackoverflow.com/questions/16798017/set-default-route-to-devise-login-view-for-rails-server',
  'https://stackoverflow.com/questions/78212780/installing-rails-error-unable-to-lock-database-permission-denied-nothing-work',
  'https://stackoverflow.com/questions/57797880/rails-5-2-polymorphic-association-with-polymorphic-conditional',
  'https://stackoverflow.com/questions/78129670/activerecord-query-for-count-of-association-using-a-join-table',
  'https://rspec.info/features/6-1/rspec-rails/model-specs/',
]
sample_urls.each do |url|
  link = Link.create!(
    url: url
  )

  (1..100).to_a.sample.times do
    View.create!(
      link: link
    )
  end
end

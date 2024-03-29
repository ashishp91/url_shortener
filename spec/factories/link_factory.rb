FactoryBot.define do
  factory :link do
  end

  factory :github_home_link, parent: :link do
    url { 'https://github.com' }
  end

  factory :ror_discuss_forum, parent: :link do
    url { 'https://discuss.rubyonrails.org' }
  end

end

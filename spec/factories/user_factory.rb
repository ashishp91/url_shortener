FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :sample_user, parent: :user do
  end
end

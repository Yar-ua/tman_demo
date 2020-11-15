FactoryBot.define do
  factory :project do
    association :user, factory: :user

    name { Faker::Company.catch_phrase }
  end
end
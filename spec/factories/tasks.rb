FactoryBot.define do
  factory :task do
    association :project, factory: :project

    name { Faker::Company.catch_phrase }
    priority { Faker::Number.within(range: 1..5) }
    deadline { Faker::Time.between(from: DateTime.now, to: DateTime.now + 31, format: :default) }
  end
end
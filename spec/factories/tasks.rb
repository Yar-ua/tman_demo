FactoryBot.define do
  factory :task do
    association :project, factory: :project

    name { Faker::Company.catch_phrase }
    priority { Faker::Number.within(range: 1..5) }
    status { Faker::Number.within(range: 0..1) }
    deadline { Faker::Time.between(from: DateTime.now, to: DateTime.now + 31, format: :default) }
  end
end
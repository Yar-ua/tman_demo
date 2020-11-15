FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password }
  end
  
  factory :myuser, class: "User" do
    email { '1@mail.com' }
    password { '111111' }
  end
end
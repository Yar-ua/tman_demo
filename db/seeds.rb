require 'faker'

2.times do
  user = FactoryBot.create(:user)
  3.times do
    project = FactoryBot.create(:project, user: user)
    (Faker::Number.within(range: 2..7)).times do
      task = FactoryBot.create(:task, project: project)
    end
  end
end


myuser = FactoryBot.create(:myuser)

3.times do
  project = FactoryBot.create(:project, user: myuser)
  5.times do
    task = FactoryBot.create(:task, project: project)
  end
end

gproject = FactoryBot.create(:gproject, user: myuser)
(Faker::Number.within(range: 10..12)).times do
  task = FactoryBot.create(:task, project: gproject)
end
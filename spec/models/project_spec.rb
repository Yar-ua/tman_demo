require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:project) {FactoryBot.create(:project, user: user)}

  it 'user after Factory valid with valid attributes' do
    expect(project).to be_valid
  end

  describe 'oil must have all important attributes' do
    it { expect(:name).to be}
    it { expect(:user_id).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end

  describe 'trying to create and validate project with or without nesessary attributes' do
    it 'without name - invalid' do
      project = Project.new
      expect(project.valid?).to eq(false)
    end

    it 'without name user_id - invalid' do
      project = Project.new(name: 'drink tea')
      expect(project.valid?).to eq(false)
    end  

    it 'with right and full params - valid' do
      project = Project.new(name: "drink tea", user_id: user.id)
      expect(project.valid?).to eq(true)
    end
  end
end

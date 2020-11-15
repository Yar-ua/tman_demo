require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:project) {FactoryBot.create(:project, user: user)}
  let(:task) {FactoryBot.create(:task, project: project)}

  it 'user after Factory valid with valid attributes' do
    expect(task).to be_valid
  end

  describe 'oil must have all important attributes' do
    it { expect(:name).to be}
    it { expect(:priority).to be}
    it { expect(:status).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end

  describe 'trying to create and validate task with or without nesessary attributes' do
    it 'without name - invalid' do
      task = Task.new(priority: '')
      expect(task.valid?).to eq(false)
    end

    it 'without priority or status - invalid' do
      task.priority = 'asdasd'
      expect(task.valid?).to eq(false)
      task.priority = nil
      expect(task.valid?).to eq(false)      
      task.status = nil
      expect(task.valid?).to eq(false)
    end  

  end

  describe 'test up and down methods' do
    it 'testing up method' do
      task.priority = 4
      expect(task.priority).to eq(4)
      task.up
      expect(task.priority).to eq(5)
      task.up
      expect(task.priority).to eq(5)
    end

    it 'testing down method' do
      task.priority = 2
      expect(task.priority).to eq(2)
      task.down
      expect(task.priority).to eq(1)
      task.down
      expect(task.priority).to eq(1)
    end    
  end

  describe 'test status enum\'s' do
    it 'enums' do
      task.in_process!
      expect(task.status).to eq('in_process')
      task.done!
      expect(task.status).to eq('done')
    end
  end
end

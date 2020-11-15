require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create(:user)}

  it 'user after Factory valid with valid attributes' do
    expect(user).to be_valid
  end

  describe 'oil must have all important attributes' do
    it { expect(:email).to be}
    it { expect(:password).to be}
    it { expect(:created_at).to be}
    it { expect(:updated_at).to be}
  end

  describe 'trying to create user with without nesessary attributes' do

    it 'with wrong email - invalid' do
      user = User.new(email: '123')
      expect(user.valid?).to eq(false)
    end

    it 'without passwort - invalid' do
      user = User.new(email: '123@mail.com')
      expect(user.valid?).to eq(false)
    end    

    it 'with short passwort - invalid' do
      user = User.new(email: '123@mail.com', password: '123')
      expect(user.valid?).to eq(false)
    end

    it 'with nesessary parameters - valid' do
      user = User.new(email: '123@mail.com', password: '123456')
      expect(user.valid?).to eq(true)
    end    

  end

end

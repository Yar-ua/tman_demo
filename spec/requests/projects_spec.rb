 require 'rails_helper'
 
 RSpec.describe ProjectsController, type: :controller do

  it 'index - permitted for unregistred users' do
    get :index
    expect(response.status).to eq(200)
  end

  describe 'testing CRUD' do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, user: @user)
    end

    describe 'when user unauthorized' do

      it 'create project - forbidden' do
        @new_project = FactoryBot.attributes_for(:project, user: @user)
        post :create, params: {project: @new_project}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'update project - forbidden' do
        @project.name = '111name'
        put :update, params: {id: @project.id, project: @project}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'create project - forbidden' do
        delete :destroy, params: {id: @project.id,}, xhr: true
        expect(response.status).to eq(401)
      end
    end
  end
end
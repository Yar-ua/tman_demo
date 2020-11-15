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
      @new_project = FactoryBot.attributes_for(:project, user: @user)
    end

    describe 'when user unauthorized' do
      it 'create project - forbidden' do
        post :create, params: {project: @new_project}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'update project - forbidden' do
        @project.name = '111name'
        put :update, params: {id: @project.id, project: @project}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'delete project - forbidden' do
        delete :destroy, params: {id: @project.id,}, xhr: true
        expect(response.status).to eq(401)
      end
    end


    describe 'test crud when user authorized' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it 'create' do
        post :create, params: {project: @new_project}, xhr: true
        expect(response.status).to eq(200)
        expect(@user.projects.count).to be > 0
      end

      it 'update' do
        @project.name = "newname"
        put :update, params: {id: @project.id, project: {name: @project.name}}, xhr: true
        expect(response.status).to eq(200)
        expect(Project.find(@project.id).name).to eq(@project.name)
      end

      it 'destroy' do
        delete :destroy, params: {id: @project.id}, xhr: true
        expect(response.status).to eq(200)
      end
    end

    describe 'forbidden area if user is not project owner' do
      before do
        @new_user = FactoryBot.create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @new_user
        @project = FactoryBot.create(:project, user: @user)
      end

      it 'forbidden to update' do
        @project.name = "new name for update"
        put :update, params: {id: @project.id, project: {name: @project.name}}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'forbidden to delete' do
        delete :destroy, params: {id: @project.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end      
    end

  end
end
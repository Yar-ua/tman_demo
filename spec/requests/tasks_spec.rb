 require 'rails_helper'
 
 RSpec.describe TasksController, type: :controller do

  describe 'testing CRUD' do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, user: @user)
      @task = FactoryBot.create(:task, project: @project)
      @new_task = FactoryBot.attributes_for(:task, project: @project)
    end

    describe 'when user unauthorized' do
      it 'create task - forbidden' do
        post :create, params: {project_id: @project.id, task: @new_task}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'update task - forbidden' do
        @task.name = 'new task'
        put :update, params: {project_id: @task.project_id, id: @task.id, task: {name: @task.name}}, xhr: true
        expect(response.status).to eq(401)
      end

      it 'delete task - forbidden' do
        delete :destroy, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(401)
      end
    end

    describe 'test crud when user authorized' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it 'create' do
        post :create, params: {project_id: @project.id, task: @new_task}, xhr: true
        expect(response.status).to eq(200)
        expect(@user.projects.count).to be > 0
      end

      it 'update' do
        @task.name = 'new task'
        put :update, params: {project_id: @task.project_id, id: @task.id, task: {name: @task.name}}, xhr: true
        expect(response.status).to eq(200)
        expect(Project.find(@project.id).name).to eq(@project.name)
      end

      it 'destroy' do
        delete :destroy, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it 'up' do
        put :up, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it 'down' do
        put :down, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it 'done' do
        put :done, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it 'inprocess' do
        put :inprocess, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(200)
      end
    end


    describe 'forbidden area if not project owner' do
      before do
        @new_user = FactoryBot.create(:user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @new_user
      end

      it 'create' do
        post :create, params: {project_id: @project.id, task: @new_task}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'update' do
        @task.name = 'new task'
        put :update, params: {project_id: @task.project_id, id: @task.id, task: {name: @task.name}}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'destroy' do
        delete :destroy, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'up' do
        put :up, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'down' do
        put :down, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'done' do
        put :done, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end

      it 'inprocess' do
        put :inprocess, params: {project_id: @task.project_id, id: @task.id}, xhr: true
        expect(response.status).to eq(442)
        expect(response.body).to include("Forbidden - not owner")
      end
    end

  end
end
class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_project, only: [:update, :destroy]

  def index
    @projects = Project.all
    @project = Project.new
    @task = Task.new
  end

  def create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path  }
        format.js
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if is_owner
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to projects_path }
          format.js
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if is_owner
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_path }
        format.js
      end
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def is_owner
    if current_user.id == @project.user_id
      return true
    else
      respond_to do |format|
        format.js { render status: 442, json: {message: "Forbidden - not owner"} }
      end
    end
  end
end

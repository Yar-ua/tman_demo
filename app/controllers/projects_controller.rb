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
          format.json { render :show, status: :ok, location: @project }
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
        format.json { head :no_content }
      end
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
    rescue ActiveRecord::RecordNotFound
      render json: { error: "not found" }, status: :not_found
  end

  def is_owner
    return true if current_user.id == @project.user_id
  end
end

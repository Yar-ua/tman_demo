class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:index, :new]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def done
    if @task.done!
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Task was successfully done.' }
        format.json { render :show, status: :ok, location: @task }
      end
    end
  end

  def inprocess
    if @task.in_process!
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Task was switchet to "in process".' }
        format.json { render :show, status: :ok, location: @task }
      end
    end
  end  

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def up
    if @task.up
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Task priority was upped.' }
        format.json { render :show, status: :ok, location: @task }
      end
    end
  end

  def down
    if @task.down
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Task was successfully lowed.' }
        format.json { render :show, status: :ok, location: @task }
      end
    end
  end

  private
    
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :status, :deadline, :priority)
  end
end

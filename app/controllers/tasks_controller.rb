class TasksController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_project
  before_action :set_task, except: [:index, :new, :create]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    if is_owner
      @task = @project.tasks.build(task_params)
      respond_to do |format|
        if @task.save
          flash[:notice] = 'Task was successfully created.' 
          format.html { redirect_to root_path }
          format.js
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if is_owner
      respond_to do |format|
        if @task.update(task_params)
          flash[:notice] = 'Task was successfully updated.'
          format.html { redirect_to root_path }
          format.js
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def done
    if is_owner
      if @task.done!
        flash[:notice] = 'Task was successfully done.' 
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
          format.json { render :show, status: :ok, location: @task }
        end
      end
    end
  end

  def inprocess
    if is_owner
      if @task.in_process!
        flash[:notice] = 'Task was switchet to "in process.'
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
          format.json { render :show, status: :ok, location: @task }
        end
      end
    end
  end  

  def destroy
    if is_owner
      @task.destroy
      flash[:notice] = 'Task was successfully destroyed.' 
      respond_to do |format|
        format.html { redirect_to root_path}
        format.js
        format.json { head :no_content }
      end
    end
  end

  def up
    if is_owner
      if @task.up
        flash[:notice] = 'Task priority was upped.'
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
          format.json { render :show, status: :ok, location: @task }
        end
      end
    end
  end

  def down
    if is_owner
      if @task.down
        flash[:notice] = 'Task priority was lowed.'
        respond_to do |format|
          format.html { redirect_to root_path  }
          format.js
          format.json { render :show, status: :ok, location: @task }
        end
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

  def is_owner
    return true #if current_user.id == @project.user_id
  end
end

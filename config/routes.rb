Rails.application.routes.draw do
  
  devise_for :users
  
  root to: 'projects#index'
  
  resources :projects, except: [:new, :show, :edit] do
    resources :tasks, except: [:index, :new, :show, :edit]
  end

  put '/projects/:project_id/tasks/:id/done', to: 'tasks#done', as: 'project_task_done'
  put '/projects/:project_id/tasks/:id/inprocess', to: 'tasks#inprocess', as: 'project_task_inprocess'
  put '/projects/:project_id/tasks/:id/up', to: 'tasks#up', as: 'project_task_up'
  put '/projects/:project_id/tasks/:id/down', to: 'tasks#down', as: 'project_task_down'

end

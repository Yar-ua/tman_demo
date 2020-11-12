Rails.application.routes.draw do
  
  root to: 'projects#index'
  
  resources :projects do
    resources :tasks do
    end
  end

  get '/projects/:project_id/tasks/:id/done', to: 'tasks#done', as: 'project_task_done'

end

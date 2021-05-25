Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  root :to => 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/user-one' => 'users#user_one'
  get '/users-all' => 'users#user_all'
  post '/user_login' => 'users#user_login'


  get '/projects-user/:user' => 'projects#user_projects'
  get '/project-read/:project_id' => 'projects#project_read'
  get '/project-user/:project_id' => 'projects#user_project'
  get '/project-user-status/:project_id/:status' => 'projects#user_project_status'
  post '/project-priority-update' => 'projects#project_priority_update'
  post '/project-create' => 'projects#create_project'
  post '/project-update' => 'projects#update_project'
  delete '/project-delete' => 'projects#project_delete'

  get '/project-categories-all' => 'project_categories#categories_all'
  get '/task-categories-all' => 'task_categories#categories_all'

  get '/task-read' => 'tasks#read_task'
  post '/task-create' => 'tasks#create_task'
  post '/task-update' => 'tasks#update_task'
  post '/task-priority-update' => 'tasks#task_priority_update'
  delete '/task-delete' => 'tasks#delete_task'

  post '/note-create/:task_id/:user_id' => 'notes#create_note'

end

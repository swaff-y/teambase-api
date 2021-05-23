Rails.application.routes.draw do
  root :to => 'pages#home'
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

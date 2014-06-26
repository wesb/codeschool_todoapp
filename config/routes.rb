Rails.application.routes.draw do
  resources :users
  resources :tasks
  resource :session
end

Rails.application.routes.draw do
  devise_for :user, only: []


  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
  end

  resources :user_promises
  get    '/'  => 'sessions#new'
  get    'signup'  => 'users#new'
  post   'users'   => 'users#create'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
  end


  resources :houses do
    resources :property_managers
    resources :messages
    resources :rules
    resources :communal_items
    resources :events
    resources :chores do
      resources :chore_logs
    end
  end

  get '/houses/:id/join' => 'houses#join'
  post '/houses/:id/join' => 'houses#join_update'

end

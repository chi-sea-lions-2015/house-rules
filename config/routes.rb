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

  get '/houses/:house_id/rules/:rule_id/issues/rule_issue_new' => 'issues#rule_issue_new'
  post '/houses/:house_id/rules/:rule_id/issues/rule_issue_create' => 'issues#rule_issue_create'
  get '/houses/:house_id/chores/:chore_id/issues/chore_issue_new' => 'issues#chore_issue_new'
  post '/houses/:house_id/chores/:chore_id/issues/chore_issue_create' => 'issues#chore_issue_create'
  get '/houses/:house_id/items/:item_id/issues/item_issue_new' => 'issues#item_issue_new'
  post '/houses/:house_id/items/:item_id/issues/item_issue_create' => 'issues#item_issue_create'
  get '/houses/:house_id/events/:event_id/issues/event_issue_new' => 'issues#event_issue_new'
  post '/houses/:house_id/events/:event_id/issues/event_issue_create' => 'issues#event_issue_create'
end

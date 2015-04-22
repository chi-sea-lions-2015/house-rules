Rails.application.routes.draw do


  get    '/'  => 'sessions#new'
  get    'signup'  => 'users#new'
  post   'users'   => 'users#create'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get "/houses/:id/roommates" => 'houses#roommates'

  resources :users do
  end

  get '/houses/:id/roommates', to: 'users#index'


  resources :houses do
    resources :property_managers
    resources :messages
    resources :rules
    resources :communal_items
    resources :events
    resources :chores, shallow: true do
      resources :chore_logs, only: [:create, :show, :destroy]
    end
  end

  get '/houses/:id/roommates', to: 'users#index'

  get '/houses/:id/join' => 'houses#join'
  post '/houses/:id/join' => 'houses#join_update'


  post '/houses/:house_id/communal_items/:id/high' => 'communal_items#high'
  post '/houses/:house_id/communal_items/:id/low' => 'communal_items#low'
  post '/houses/:house_id/communal_items/:id/out' => 'communal_items#out'

  post '/houses/:house_id/communal_items/:communal_item_id/promise' => 'user_promises#create'
  post '/houses/:house_id/communal_items/:communal_item_id/promise_fulfilled' => 'user_promises#update'

  post '/houses/:house_id/communal_items/:communal_item_id/issue' => 'issues#item_issue_create'

end

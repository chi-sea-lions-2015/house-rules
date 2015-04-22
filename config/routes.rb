Rails.application.routes.draw do

  resources :user_promises
  get    '/'  => 'sessions#new'
  get    'signup'  => 'users#new'
  post   'users'   => 'users#create'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
  end

get '/houses/:id/roommates', to: 'users#index'

  resources :houses do
    resources :property_managers, shallow: true
    resources :messages, shallow: true
    resources :rules, shallow: true
    resources :communal_items, shallow: true
    resources :events, shallow: true
    resources :chores, only: [:show, :index, :create, :destroy] do
      resources :chore_logs, only: [:create, :show, :destroy]
    end
  end

get '/houses/:id/roommates', to: 'users#index'

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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

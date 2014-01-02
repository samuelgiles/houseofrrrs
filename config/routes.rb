Houseofrrrs::Application.routes.draw do
  get "purchases/overview"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'application#home'
  get '/login' => 'sessions#new', :as => :session_new
  post '/login' => 'sessions#create', :as => :session_create
  get '/logout' => 'sessions#destroy', :as => :session_destroy
  get '/tasks' => 'application#home', :as => :tasks
  get '/items' => 'items#overview', :as => :items_overview
  get '/need' => 'items#need', :as => :need
  post '/need' => 'items#create', :as => :need_create
  get '/bought' => 'items#purchased', :as => :purchased
  post '/bought' => 'items#createpurchase', :as => :purchased_create
  get '/purchases' => 'purchases#overview', :as => :purchases
  get '/pay' => 'purchases#payuser', :as => :pay
  get '/removepurchase' => 'items#removepurchase', :as => :remove_purchase

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

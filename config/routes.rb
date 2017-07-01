Rails.application.routes.draw do
  
  use_doorkeeper
  devise_for :users

  resources :events do 
    collection do 
      post "/:id/event_items/:event_item_id/assign", to: "events#assign_item"
      post "/:id/event_items", to: "events#add_item"
      delete "/:id/event_items/:event_item_id", to: "events#delete_item"
      post "/:id/add_user", to: "events#add_user"
      post "/:id/add_item", to: "events#add_item"
    end
  end

  resources :users, only: [:create, :index, :show] do 
    collection do 
      post "/update_token", to: "users#update_token"
    end
  end

  resources :items, only: [ :index ]

  resources :event_items do
    collection do
      post "/:id/buy_item", to: "event_items#buy_item"
    end
  end

  # api versions: 1, module: "api/v1" do
  #   resources :events, only: [:index] do
  #     # collection do
  #     #   post "/:id/add_role", to: "users#add_role_to_user"
  #     #   post "/:id/add_permission", to: "users#add_permission_to_view_a_list"
  #     #   get "filter", to: "users#filter_by_role"
  #     #   get "/:id/lists", to: "users#get_lists"
  #     # end
  #   end 
  # end
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

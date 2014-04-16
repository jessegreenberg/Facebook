Facebook::Application.routes.draw do

	# recources gives us all actions needed for 
	# re-routing to root so 
	# we have ability to create on home page.
	resources :users
	#sessions resource with new, create, and destroy, gives us 
	#everything we need to control sign in and sign out of users.
	resources :sessions, only: [:new, :create, :destroy]
	resources :userposts, only: [:create, :destroy, :index]
	root 'users#new'
	match '', to: 'sessions#new', via: 'get'
	match '/signout', to: 'sessions#destroy', via: 'delete' 
	# All of the routes below should probably be in the users resource!
	match '/newsfeed', to: 'facebook_pages#newsfeed', via: 'get'
	match '/preferences', to: 'facebook_pages#profile_preferences', via: 'get'
	match '/friends', to: 'facebook_pages#friend_list', via: 'get'
	match '/results', to: 'facebook_pages#friend_search', via: 'get'
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

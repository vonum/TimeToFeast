Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :users, only: [:index, :show] do
    member do
      get 'profile'
      get 'friends'
      get 'accept_invite'
      get 'decline_invite'
    end
    collection do
      get 'reservations'
      get 'schedule'
      post 'grade'
      get 'search'
    end
  end
  resources :restaurants do
    resources :tables do
      resources :reservations, only: [:index, :new, :create, :show] do
        member do
          get 'invite'
        end
      end
    end
    collection do
      get 'meals'
      get 'edit_meals'
      get 'search'
    end
    member do
      get 'reservations'
      post 'add_meal'
      post 'delete_meal'
    end
  end

  resources :meals, only: [:index, :new, :create, :destroy, :edit, :update]

  resources :friendships, only: [:destroy] do
    member do
      get 'send_request'
      get 'accept_request'
      get 'decline_request'
    end
  end
  resources :managers, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  root 'home#index'

  get 'invitation/:reservation_id/:user_id' => 'invitation#invite'

  get 'test' => 'home#test'
  get 'test2' => 'home#test2'
  post 'tmp' => 'home#tmp', as: 'tmp'

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

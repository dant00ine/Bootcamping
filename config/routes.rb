Rails.application.routes.draw do
  
    root 'static_pages#index'
    # get 'static_pages/about'
    get 'about' => 'static_pages#about'
    get 'search'=> 'static_pages#search'

    #  Bootcamps    
    resources :bootcamps do
        resources :cohorts
        post 'review' => 'bootcamps#review'
    end

    # Users / Profiles
    get 'students'=> 'users#students'
    get 'recruiters'=> 'users#recruiters'
    get 'jobs'=> 'users#recruiters'
    
    resources :users do
        patch "profile" => "users#update_profile"

        post "bootcamps_add" => 'profiles#bootcamps_add'
        patch "bootcamps_update" => 'profiles#bootcamps_update'
    end

    # Sign Up and Sign In
    get  'login'  => 'sessions#new'
    post 'login'  => 'sessions#create'
    get  'logout' => 'sessions#destroy'


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

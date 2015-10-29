Rails.application.routes.draw do
  
  get 'tips/new'

  get 'tips/create'

  get 'tips/show'

  get 'tips/index'

  resources :contacts, only: [:new, :create]

  resources :conversations do
    resources :messages
  end
  resources :tips do
    member do
      put "like", to: "tips#upvote"
    end
  end
  devise_for :users do
  delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
end
get 'top/tips' => 'tips#top', :as => :top_tips
  resources :users, :only => [:show, :index, :destroy] do
    member do
      get :following, :followers
    end
  end

  get 'static_pages/News'

  get 'static_pages/About'
 
resources :relationships,       only: [:create, :destroy]
  get 'static_pages/Contact'
  get 'mniams/home'
   get 'mniams/favorite_list'
  resources :mniams do
    put :favorite, on: :member
    member do
      put "like", to: "mniams#upvote"
    end
  end
  get 'tags/:tag', to: 'mniams#home', as: :tag
  root "mniams#home"
 resources :comments, only: [:create]
get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  get '/download_pdf/:id(.:format)' => 'mniams#show', :method => :get, :as=>:show

  get '/filtering_tips/(:id)' => 'tips#filtering_tips', :as => :filtering_tips

  get '/filtering_movies/(:id)' => 'mniams#filtering_mniams', :as => :filtering_mniams
  get '/filtering_mniams2/(:id)' => 'mniams#filtering_mniams2', :as => :filtering_mniams2
  get 'feed' => 'users#feed', :as => :feed_list
  get 'top' => 'mniams#top', :as => :top
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

Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  root to: "pages#index"

  scope :services, controller: :services do
    root action: :index, as: :services
    get ":id", action: :show, as: :service
  end

  scope :publications, controller: :publications do
    root action: :index, as: :publications
    get ":id", action: :show, as: :publication
  end

  scope :interesting_articles, controller: :interesting_articles do
    root action: :index, as: :interesting_articles
    get ":id", action: :show, as: :interesting_article
  end



  controller :pages do
    get "about-us", action: "about_us", as: :about_us
    get "pricing", action: "pricing", as: :pricing
    get "contacts", action: "contacts", as: :contacts
  end


  post "message", to: "messages#create"


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]


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

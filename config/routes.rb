Rails.application.routes.draw do
  mount Cms::Engine => '/', as: 'cms'
  mount Ckeditor::Engine => '/ckeditor'

  localized do
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
  end

  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end

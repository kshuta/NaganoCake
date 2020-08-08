Rails.application.routes.draw do
  ### creating scope :public without altering URL. 
  scope module: :public do
    root to: 'homes#top'
    resource :end_users, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]

    ## routing for cart items
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete "cart_items/" => "cart_items#destroy_all", as: "destroy_all_cart_items"

    ## routing for order
    post "orders/confirm" => "orders#confirm", as: "order_confirm"
    get "orders/done" => "orders#done", as: "order_done"
    resources :orders, only: [:index, :new, :show, :create]


    ## routing for devise and controllers
    get "end_users/unregister/confirm" => "end_users#confirm", as: "end_users_unregister"
    devise_for :end_users, controllers: {sessions: "public/end_users/sessions", registrations: 'public/end_users/registrations', passwords: 'public/end_users/passwords'}
  end

  ### creating scope :admin without altering URL.
  scope module: :admin do 
    devise_for :admin, controllers: {sessions: 'admin/admin/sessions', passwords: 'admin/admin/passwords'}
  end
  # creating namespace :admin and altering url
  namespace :admin do
    get '/items/search' => 'items#search', as: :item_search
    resources :end_users, only: [:index]
    resources :genres, only: [:index, :edit, :update, :create]
    resources :items, only: [:index, :new, :create, :show]
    resources :orders, only: [:index, :show, :update]
    resource :order_details, only: [:update]
    get '/' => 'homes#top', as: :top
  end

end

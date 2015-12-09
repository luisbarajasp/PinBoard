Rails.application.routes.draw do

  get 'likes/index'

  devise_for :users

  resources :users, :only => [:show,:index,:likes] do
      resources :boards
      resources :likes , only: [:index]
  end

    devise_scope :user do
      get "sign_out", :to => 'devise/sessions#destroy'
      get "sign_in", :to => "devise/sessions#new"
      authenticated :user do
        root :to => 'pins#index', as: :authenticated_root
      end
      unauthenticated :user do
        root :to => 'pages#welcome', as: :unauthenticated_root
      end
    end

  get 'pages/welcome'

  get 'pages/about'

  get 'pages/contact'

  resources :pins do
     member do
        put "like", to: "pins#like"
        put "dislike", to: "pins#unlike"
    end
  end

  get '*path' => redirect('/')
  #root 'pages#welcome'

end

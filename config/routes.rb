Rails.application.routes.draw do

  get 'its/new'

  get 'likes/index'

  devise_for :users

  resources :users, :only => [:show,:index,:likes] do
      resources :boards do
          member do
             get "follow", to: "boards#follow"
             get "unfollow", to: "boards#unfollow"
         end
         get "followers", to: "followers#board"
      end
      resources :likes , only: [:index]
      resources :followers , only: [:index]
      resources :following , only: [:index]
      member do
         get "follow", to: "users#follow"
         get "unfollow", to: "users#unfollow"
     end
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
      resources :its, only: [:new,:create,:destroy]
     member do
        put "like", to: "pins#like"
        put "dislike", to: "pins#unlike"
    end
  end

  get '*path' => redirect('/')
  #root 'pages#welcome'

end

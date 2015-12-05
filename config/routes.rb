Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users

    devise_scope :user do
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

  resources :pins

end

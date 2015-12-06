Rails.application.routes.draw do

  devise_for :users

  resources :users, :only => [:show,:index]

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

  resources :pins

  get '*path' => redirect('/')
  #root 'pages#welcome'

end

Rails.application.routes.draw do
  resources :tweets
  devise_for :users, :controllers => { :registrations => "registrations" }
    devise_scope :user do
      authenticated :user do
        root to: "tweets#index"
      end
      unauthenticated :user do
        root to: "devise/sessions#new", as: :unauthenticated_root
      end
    end
    resources :users, only: [:index, :show]
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
end

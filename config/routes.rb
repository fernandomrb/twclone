Rails.application.routes.draw do
  
  authenticated :user do
    root to: "tweets#index", as: :authenticated_root
  end
  unauthenticated do
    root to: "main#index"
  end
  devise_for :users
  devise_scope :user do
    post "/users/pre_register", to: "registrations#preRegister", as: :pre_registration
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/users/:id", to: "profiles#show", as: :profile_user
  get "/tweets/:id/like", to: "tweets#like", as: :like_tweet
  get "/tweets/:id/dislike", to: "tweets#dislike", as: :dislike_tweet

  post '/users/:username/follow_user', to: "relationships#follow_user", as: :follow_user
  post '/users/:username/unfollow_user', to: "relationships#unfollow_user", as: :unfollow_user
  
  resources :tweets
end

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
  
  resources :tweets do
    member do
      post :reply
    end
  end
  get "/users/:id", to: "profiles#show", as: :profile_user
  put "/tweets/:id/like", to: "tweets#like", as: :like_tweet
  put "/tweets/:id/dislike", to: "tweets#dislike", as: :dislike_tweet
  
  get "/tweets/:id/retweet", to: "tweets#new", as: :new_retweet
  post "/tweets/:id/retweet", to: "tweets#retweet", as: :retweet
  delete "/tweets/:id/retweet", to: "tweets#destroy_retweet", as: :destroy_retweet 
  post '/users/:username/follow_user', to: "relationships#follow_user", as: :follow_user
  post '/users/:username/unfollow_user', to: "relationships#unfollow_user", as: :unfollow_user
  
  get "/notifications", to: "notifications#index", as: :notification

  mount ActionCable.server => "/cable"
end

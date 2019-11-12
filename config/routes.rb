Rails.application.routes.draw do
  
  authenticated :user do
    root to: "tweets#index", as: :authenticated_root
  end
  unauthenticated do
    root to: "main#index"
  end
  devise_for :users
  resources :users, only: [:index]
  devise_scope :user do
    post "/users/pre_register", to: "registrations#preRegister", as: :pre_registration
  end
  
  resources :tweets
  resources :conversations do
    resources :personal_messages, only: [:create]
  end
  
  put "/tweets/:id/like", to: "tweets#like", as: :like_tweet
  put "/tweets/:id/dislike", to: "tweets#dislike", as: :dislike_tweet
  
  get "/tweets/:parent_id/reply", to: "tweets#new", as: :reply_tweet
  get "/tweets/:parent_id/reply", to: "tweets#create"
  get "/tweets/:src_tweet/retweet", to: "tweets#new", as: :new_retweet
  post "/tweets/:src_tweet/retweet", to: "tweets#retweet", as: :retweet
  delete "/tweets/:id/retweet", to: "tweets#destroy_retweet", as: :destroy_retweet 
  post '/users/:username/follow_user', to: "relationships#follow_user", as: :follow_user
  post '/users/:username/unfollow_user', to: "relationships#unfollow_user", as: :unfollow_user
  
  get "/notifications", to: "notifications#index", as: :notification

  get "/search", to: "main#search", as: :search

  mount ActionCable.server => "/cable"

  get "/users/:username", to: "profiles#show", as: :profile_user, constraint: { username: /[\w]+/ }
  get "/users/:username/following", to: "profiles#following", as: :user_following, constraint: { username: /[\w]+/ }
  get "/users/:username/followers", to: "profiles#followers", as: :user_followers, constraint: { username: /[\w]+/ }

end

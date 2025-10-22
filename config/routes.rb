Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "tags/index"
      get "tags/show"
      get "tags/create"
      get "tags/update"
      get "tags/destroy"
      get "comments/index"
      get "comments/create"
      get "comments/update"
      get "comments/destroy"
      get "posts/index"
      get "posts/show"
      get "posts/create"
      get "posts/update"
      get "users/index"
      get "users/show"
      get "users/create"
      resources :users
      resources :posts do
        resources :comments
      end
      resources :tags
    end
  end

  # Defines the root path route ("/")
  root "hello#index"
end

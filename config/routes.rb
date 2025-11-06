Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # /api/v1/posts/:post_id/comments gibi iç ice rotalari olusturur.
      # Sadece bir posta ait yorumları listelemek (index) ve yeni yorum oluşturmak (create) için.
      resources :posts do
        resources :comments, only: [:index, :create]
      end

      # /api/v1/comments/:id gibi tekil yorum rotaları (gösterme, güncelleme, silme için).
      resources :comments, only: [:show, :update, :destroy]
      resources :users, only: [:index, :show]
      resources :tags, only: [:index, :show]    
    end
  end

  # Arayüz rotası
  resources :posts, only: [:show]
end

Rails.application.routes.draw do
  # ルートパスを設定
  root "good_memories#index"
  
  # 月別表示のルート
  get 'monthly/:year/:month', to: 'good_memories#monthly', as: :monthly_memories
  
  # 良い思い出のリソース
  resources :good_memories
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end

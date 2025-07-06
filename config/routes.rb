Rails.application.routes.draw do
  # ルートパスを設定
  root "good_memories#index"
  
  # 月別表示のルート
  get 'monthly/:year/:month', to: 'good_memories#monthly', as: :monthly_memories
  get 'months', to: 'good_memories#months', as: :months
  
  # 今日の記録を編集
  get 'edit_today', to: 'good_memories#edit_today', as: :edit_today
  
  # 良い思い出のリソース
  resources :good_memories
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end

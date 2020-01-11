Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

# トップページ
  root to: 'toppages#top'

# ユーザー
  resources :users, only: [:show, :edit, :update] do
    member do
      patch :leave # 退会機能
      get :activity # 活動履歴表示ページ
      get :friend # フレンド一覧ページ
    end
  end

# フレンド機能
  resources :relationships, only: [:create, :destroy]

# コミュニティメンバー
  resources :members, only: [:create, :edit, :update, :destroy]

# コミュニティ
  resources :communities do
    member do
      patch :closed #募集締め切りに切り替える
      patch :held #開催済に切り替える
    end
  end

# チャットルーム
  resources :chats, only: [:show]

# テニスコート
  resources :tenniscourts, only: [:index, :show]

# 検索機能
  resources :searchs, only: [:search]

end

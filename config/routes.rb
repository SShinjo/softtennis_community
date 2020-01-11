Rails.application.routes.draw do
  get 'searchs/search'
  get 'tenniscourts/index'
  get 'tenniscourts/show'
  get 'chats/show'
  get 'communities/new'
  get 'communities/index'
  get 'communities/edit'
  get 'relationships/index'
  get 'users/edit'
  get 'users/activity'
  get 'users/show'
  get 'members/edit'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

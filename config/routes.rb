Rails.application.routes.draw do
  devise_for :users, path: 'user', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: "pages#home"
  resources :bookmarks, path: 'b'
  patch 'b/:id/archive', to: 'bookmarks#archive', as: 'archive_bookmark'
  get 'user/profile', to: 'users#show', as: 'show_user'
  resources :groups, path: 'g'
  delete 'g/:group_id/:user_id', to: 'groups#delete_user', as: 'delete_user_from_group'
  get 'g/:group_id/new-user', to: 'groups#new_user', as: 'new_user_for_group'
  post 'g/:group_id/new-user', to: 'groups#add_user', as: 'add_user_to_group'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

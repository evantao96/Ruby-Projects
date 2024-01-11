Rails.application.routes.draw do
  root 'welcome#index'
  resources :authors
  resources :books
end
  
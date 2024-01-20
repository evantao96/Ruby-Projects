Rails.application.routes.draw do
  resources :statuses
  resources :users do 
    member do 
      delete 'remove_friendship'
      post 'send_friend_request'
      patch 'accept_friend_request'
    end
  end

  get 'friend_requests', to: 'users#friend_requests' 

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'
end

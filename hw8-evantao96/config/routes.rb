Rails.application.routes.draw do
  root 'welcome#index'
  get '/songs', to: 'songs#all'

  resources :artists, except: [:edit, :update] do
    member do
      get 'related_artists'
      get 'top_tracks'
    end
    resources :songs, except: [:edit, :update]
  end
end

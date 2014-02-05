CloudRadio::Application.routes.draw do
  
  resources :songs do
    member do
      get 'like'
      get 'unlike'
    end
  end
  get '/home' => 'users#home'
  get '/homepage' => 'users#homepage'
  get 'users/recently' => 'users#recently'
  get 'users/songsliked' => 'users#songsliked'
  get 'users/reset' => 'users#reset'
  get '/users/userlib' => 'users#userlib'
  get '/users/edit' => 'users#edit'
  devise_for :users
  root to: 'users#home'
  
end

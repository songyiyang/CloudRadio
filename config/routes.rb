CloudRadio::Application.routes.draw do
  
  resources :songs do
    member do
      get 'like'
      get 'unlike'
    end
  end
  get '/homepage' => 'users#homepage'
  get 'users/recently' => 'users#recently'
  get 'users/songsliked' => 'users#songsliked'
  get 'users/changepreference' => 'users#changepreference'
  get 'users/preference' => 'users#preference'
  get '/users/userlib' => 'users#userlib'
  get '/users/edit' => 'users#edit'
  devise_for :users
  root to: 'users#homepage'
  
end

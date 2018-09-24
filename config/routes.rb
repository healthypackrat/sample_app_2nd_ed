Rails.application.routes.draw do
  root 'static_pages#home'

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  get 'signup' => 'users#new'

  get    'signin'  => 'sessions#new'
  delete 'signout' => 'sessions#destroy'

  resources :users

  resources :sessions, only: [:create]

  resources :microposts, only: [:create, :destroy]
end

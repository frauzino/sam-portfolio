Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  get 'about' => 'pages#about', as: :about
  get 'private_lessons' => 'pages#private_lessons', as: :private_lessons

  resources :projects
  resources :photos
  resources :events
  resources :contact_form, only: %i[new create]
  get '/contact_form', to: redirect('/contact_form/new')

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end

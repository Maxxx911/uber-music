Rails.application.routes.draw do
  root 'welcome#page'
  devise_for :users
  ActiveAdmin.routes(self)
  resources :genres
  resources :events
  resources :places
  resources :users
  resources :moderators
  resources :organizations do
    member do
      get :confirm
      patch :leave
    end
  end
  resources :musician_skills
end

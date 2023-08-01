Rails.application.routes.draw do

  get 'begin', to: 'pages#begin'
  get 'news', to: 'pages#news'
  get 'ranking', to: 'pages#ranking'

  namespace :site do
    get  'welcome/index'
    get  'search', to: 'search#questions'
    get  'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end

  namespace :users_backoffice do
    get   'welcome/index'
    get   'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
    get   'list_questions', to: 'questions#list_questions', as: 'list_questions'
    resources :languages, only: [:show]
    resources :questions, only: [:show]
  end

  namespace :admins_backoffice do
    get 'welcome/index'  # Dashboard
    resources :admins    # Administradores
    resources :users     # Usuários
    resources :subjects  # Assuntos/Áreas
    resources :questions # Perguntas
    resources :languages # Linguagens
  end

  devise_for :users
  devise_for :admins, skip: [:registrations]

  get 'inicio', to: 'site/welcome#index'
  get 'backoffice', to: 'admins_backoffice/welcome#index'

  root to: 'pages#begin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

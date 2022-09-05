# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :projects do
    resources :tasks
    member do
      delete :leave_project
      delete :remove_from_project
    end
  end

  namespace :api do
    namespace :v1 do
      resources :projects,only: [] do
        member do
          post :join_team
          #邀請成員加入project的api，請輸入 email:
        end
      end
    end
  end

  resources :groups do
    member do
      post :join
      post :quit
      post :content
    end
  end
  #金流
  resource :plans
  resources :orders, except: [:edit, :update, :destroy] do
    member do
      get :pay
      post :pay, action: "submit_payment"
      delete :cancel
    end
  end
end

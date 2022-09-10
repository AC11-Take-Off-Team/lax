Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get '/users/sign_out',to: 'devise/sessions#destroy'
    get '/users', to: 'devise/registrations#new'
  end

  root to: 'home#index'

  resources :projects do
    resources :tasks, shallow: true, only: [:index, :create, :update, :destroy]
    member do
      delete :leave_project
      delete :kick_out
      get :board
      get :calendar
    end
    resources :columns, shallow: true, only: [:create, :update, :destroy] do
      member do
        post :create_task
        patch :update_task
        delete :destroy_task
      end
    end
  end


  namespace :api do
    namespace :v1 do
      resources :projects,only: [] do
        member do
          post :join_team
          patch :sort_task_position
          patch :sort_column_position
        end
      end
      resources :tasks,only: [] do
        member do
          post :status_done
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

  resources :messages
  resources :rooms

end

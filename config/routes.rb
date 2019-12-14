Rails.application.routes.draw do
  root to: 'main#index'

  get 'contact', to: 'static_pages#contact'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' },
                     path_names: { sign_in: 'login',
                                   sign_out: 'logout',
                                   password: 'secret',
                                   sign_up: 'registration' }

  resources :courses, only: :show do
    resources :lessons, only: [:index, :show]
  end

  resources :lessons, only: [] do
    resources :answers, only: [:index, :create]
  end

  resource :profile, only: [:edit, :update]

  namespace :api do
  end

  scope :admin do
    devise_for :admins, controllers: { sessions: 'admin/admins/sessions' }
  end

  namespace :admin do
    root to: 'main#index'

    resources :teachers, except: :show
    resources :disciplines, except: :show
    resources :admins, except: :show
    resources :answers, only: [:index, :destroy]

    resources :user_lessons, only: :update do
      resources :answers, only: [:new, :create, :edit, :update]
    end

    resources :courses, except: :show do
      resources :lessons, except: :show
      resources :flows, except: :show
    end

    namespace :api do
      namespace :lessons do
        resource :mass_update, only: :create
      end

      resources :lessons, only: [] do
        resources :tinymce_images, only: :create, owner: 'lesson'
      end

      resources :user_lessons, only: [] do
        resources :answers, only: :create
      end
    end
  end
end

Rails.application.routes.draw do
  resources :enrolment_requests, only: [:show, :update]

  get '/apply', to: 'enrolment_requests#apply'

  namespace :admin do
    root to: 'enrolment_requests#index'

    resources :enrolment_requests, only: [:index, :show] do
      patch 'accept', on: :member
      post 'confirm', on: :member
    end
  end
end

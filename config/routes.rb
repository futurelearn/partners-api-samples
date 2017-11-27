Rails.application.routes.draw do
  get '/apply', to: 'enrolment_requests#new'
  post '/apply', to: 'enrolment_requests#create'

  namespace :admin do
    root to: 'enrolment_requests#index'

    resources :enrolment_requests, only: [:index, :show] do
      patch 'accept', on: :member
      post 'confirm', on: :member
    end
  end
end

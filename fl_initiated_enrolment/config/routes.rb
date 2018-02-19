Rails.application.routes.draw do
  resources :enrolment_requests, only: [:show, :update] do
    get :return_to_fl, on: :member, path: 'return'
  end

  get '/apply', to: 'enrolment_requests#apply'

  namespace :admin do
    root to: 'enrolment_requests#index'

    resources :enrolment_requests, only: [:index] do
      member do
        get  :confirm_form
        post :confirm
      end
    end
  end
end

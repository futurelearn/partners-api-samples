Rails.application.routes.draw do
  resources :student_leads, only: [:index] do
    post :notify, on: :collection
  end
end

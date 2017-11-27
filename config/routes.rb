Rails.application.routes.draw do
  get '/apply', to: 'enrolment_requests#new'
  post '/apply', to: 'enrolment_requests#create'

end

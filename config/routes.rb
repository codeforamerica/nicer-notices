Rails.application.routes.draw do
  root 'page#dashboard'
  get 'page/example'
  get '/send_example', to: 'page#send_example'
  mount Cfa::Styleguide::Engine => "/cfa"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

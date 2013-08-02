Jamify::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dev', to: 'welcome#dev'
  scope '/api' do
    resources :users, only: [:index, :create]
    # the constraints allow the email to include a dot
    get '/users/:email', to: 'users#find', :constraints => { :email => /.*/ }
  end
end

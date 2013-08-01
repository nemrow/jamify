Jamify::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dev', to: 'welcome#dev'
  scope '/api' do
    resources :users
  end
end

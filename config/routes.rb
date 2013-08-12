Jamify::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dev', to: 'welcome#dev'
  scope '/api' do
    resources :users, :only => [:index, :create] do
      resources :projects, :only => [:create]
      resources :followings, :only => [:create]
    end

    # the constraints allow the email to include a dot
    get '/users/:email', to: 'users#show', :constraints => { :email => /.*/ }
    resources :projects, :except => :create do
      resources :genres, :only => [:create]
      resources :master_tracks, :only => [:create]
      resources :mix_downs, :only => [:create]
      resources :tracks, :only => [:create]
    end

    resources :tracks, :only => :none do
      resources :instruments, :only => [:create]
    end
  end
end

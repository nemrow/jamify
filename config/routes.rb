Jamify::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dev', to: 'welcome#dev'
  scope '/api' do
    resources :users, :only => [:index, :create] do
      resources :projects, :only => [:create]
      resources :followings, :only => [:create]
    end

    # the constraints allow the email to include a dot
    resources :projects, :except => :create do
      resources :genres, :only => [:create]
      resources :master_tracks, :only => [:create]
      resources :mix_downs, :only => [:create] do
        # resources :likes, :only => [:create, :destroy, :index]
      end
      resources :tracks, :only => [:create]
      # resources :likes, :only => [:create, :destroy, :index]
    end

    resources :tracks, :only => :none do
      resources :instruments, :only => [:create]
    end
    get '/users/email/:email', :to => 'users#show', :constraints => { :email => /.*/ }
    get '/users/id/:user_id', :to => 'users#show'
    get '/users/sc_id/:sc_id', :to => 'users#show'
    get '/feed', :to => 'mix_downs#index'
    get '/tracks/:track_sc_id', :to => 'tracks#show'
    get '/users/user_sc_id/follows', :to => 'followings#follows'
    get '/users/user_sc_id/followed_by', :to => 'followings#followed_by'
    get '/likes/type/:likeable_type/id/:likeable_id', :to => 'likes#index'
    get '/likes/users/:user_sc_id/type/:likeable_type', :to => 'likes#index'
    post '/likes/type/:likeable_type/id/:likeable_id', :to => 'likes#create'
    delete '/likes/id/:like_id', :to => 'likes#destroy'
  end
end

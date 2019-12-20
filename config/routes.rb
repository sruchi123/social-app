Rails.application.routes.draw do
  resources :teams
  resources :users do 
    collection do
      get 'confirm'
      post 'reset_password'
      post 'update_forget_password'
    end
    resources :messages , only: [:index, :create] do 
    end  
  end  
  post '/auth/login', to: 'authentication#login'
  delete '/auth/logout', to: 'authentication#logout'
  get '/*a', to: 'application#not_found'
  mount ActionCable.server => '/cable'


  # get '/users/:id/messages', to: 'messages#messages'
  # post '/users/:id/messages', to: 'messages#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

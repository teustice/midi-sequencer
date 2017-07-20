Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sequence#index'

  resources :sequence do
    post :play
  end

  resources :notes 

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sequence#index'

  resources :sequence do
    post :play
    post :stop
    post :record
    post :stop_record
    post :reset_sequence
    post :set_device
  end

  resources :notes

end

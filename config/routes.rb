Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :devices, only: [:update] do
    resources :temperatures, only: [:index, :create]
  end
  resources :users, only: [:show]
end

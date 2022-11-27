Rails.application.routes.draw do
  devise_for :users

  resources :listings do
		resources :images
		resources :contacts, only: :create
	end

	root to: 'listings#index'
end

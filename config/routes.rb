Rails.application.routes.draw do
  root to: "bands#index"

  resources :users do
    get 'toggleboolean'
    collection do
      get 'activate'
    end
  end
  resource :session
  resources :bands do
    resources :albums, only: [:index, :new, :create]
  end

  resources :albums, except: [:index, :new, :create]

  resources :tracks do
    resources :notes
  end

end

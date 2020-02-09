Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'projects#index'
  resources :projects, only: [:index] do
    get 'options', on: :member
    get 'items', on: :member
  end
  resources :item_collects, only: [:index] do
    get 'add_promise', on: :member
    post 'save_promise', on: :member
  end

  namespace :api do
    namespace :v1 do
      get 'search', controller: 'people'
    end
  end
end

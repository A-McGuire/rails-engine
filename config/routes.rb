Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] #do
      #   resources :items, only: [:index]
      # end
      namespace :merchants do
        get '/:merchant_id/items', to: 'search#index'
      end

      resources :items, only: [:index, :show]

      namespace :items do
        get '/:item_id/merchant', to: 'search#index'
      end
    end
  end
end

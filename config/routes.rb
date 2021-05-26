Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      
      namespace :merchants do
        get '/:merchant_id/items', to: 'merchant_items#index'
        get '/most_items', to: 'merchants#most_items'
      end
      resources :merchants, only: [:index, :show] 

      resources :items
      namespace :items do
        get '/:item_id/merchant', to: 'items_merchant#index'
      end

      ### Custom ###

      get '/revenue/merchants', to: 'merchants#most_revenue'
    end
  end
end

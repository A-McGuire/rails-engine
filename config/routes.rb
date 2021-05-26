Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      ### Custom ###
      
      get '/merchants/most_items', to: 'merchants#most_items'
      get '/revenue/merchants', to: 'merchants#most_revenue'
      
      ### REST ###
      
      resources :merchants, only: [:index, :show] 
      namespace :merchants do
        get '/:merchant_id/items', to: 'merchant_items#index'
      end
      
      resources :items
      namespace :items do
        get '/:item_id/merchant', to: 'items_merchant#index'
      end
    end
  end
end

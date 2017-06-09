Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  namespace :admin do
    resources :products do
      member do
        post :publish
        post :hide
      end
    end
  end

  namespace :admin do
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :products do
    member do
      post :add_to_cart

      post :add_to_favorite
      post :quit_favorite
    end

    collection do
      get :search
    end
  end

  resources :carts do
    collection do
      delete :clean
        post :checkout
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

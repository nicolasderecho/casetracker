Rails.application.routes.draw do
 
  root to: "home#index"

  scope :api do
    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
    end

    resources :cases
    resources :comments

    resources :users, only: [:show, :edit, :update] do
      collection do
        get :change_password
        put :update_password
      end
    end

  end
  
end
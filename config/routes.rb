Rails.application.routes.draw do
  root 'custom_forms#index'
  resources :custom_forms do
    resources :form_records, controller: 'custom_forms/form_records', only: %i[index show new create destroy] do
      post :confirmation, on: :collection
      get :finished, on: :member
    end
  end
end

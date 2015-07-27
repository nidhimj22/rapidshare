Rails.application.routes.draw do
  resources :users do
    resources :fileuploads do
      member do
        get 'download'
      end
    end
  end

  get 'login' => 'users#login'
  post 'sign_in' => 'users#sign_in'
  get 'logout' => 'users#logout'

  root 'users#login'
end

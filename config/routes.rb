Rails.application.routes.draw do
  controller :sessions do
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
end

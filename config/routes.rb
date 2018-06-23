Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  scope '/api' do
    resources :categories, only: %w(index show)
    resources :products, only: %w(show)
    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'our_school', to: 'pages#our_school'
  get 'fbla', to: 'pages#fbla'
  get 'about_us', to: 'pages#about_us'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'

  get 'donate', to: 'donations#donate'
  get 'donate/preview', to: 'donations#preview_donation'
  get 'donate/success', to: 'donations#donation_success'
  post '/donate/process_payment', to: 'donations#charge_donation'
end

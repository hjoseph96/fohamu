Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'our_school', to: 'pages#our_school'
  get 'fbla', to: 'pages#fbla'
  get 'about_us', to: 'pages#about_us'

  get 'donate', to: 'donations#donate'
  get 'donate/preview', to: 'donations#preview_donation'
  get 'donate/success', to: 'donationations#donation_sucess'
  post '/donate/process_payment', to: 'donations#charge_donation'
end

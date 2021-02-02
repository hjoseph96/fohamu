Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUB_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}
Stripe.api_key = ENV['STRIPE_SECRET_KEY']

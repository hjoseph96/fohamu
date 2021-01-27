class Donation < ApplicationRecord
  monetize :price_in_cents, allow_nil: false

  enum frequency: %i(one-time monthly yearly)
end

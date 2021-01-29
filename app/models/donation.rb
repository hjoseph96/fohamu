class Donation < ApplicationRecord
  monetize :price_in_cents, allow_nil: false

  enum frequency: %i(one_time monthly yearly)
end

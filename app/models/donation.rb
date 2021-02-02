class Donation < ApplicationRecord
  belongs_to :donor

  enum frequency: %i(one_time monthly yearly)

  def currency_symbol
    Money.new(self.price_in_cents, self.currency.to_sym).currency.symbol
  end

end

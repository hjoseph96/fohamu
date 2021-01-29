class DonationsController < ApplicationController
  def donate
  end

  def preview_donation
    donation_type = donation_params[:donation_type]
    price_in_cents = donation_params[:"#{donation_type}_price"].to_i * 100
    currency = donation_params[:"#{donation_type}_currency"]

    @donation = Donation.new(
      price_in_cents: price_in_cents,
      frequency: donation_type,
      currency: currency
    )
  end

  def cancel_donation
  end

  def charge_donation
  end

  def donation_success
  end

  private

  def donation_params
    params.require(:donation).permit(
      :donation_type, :monthly_price, :one_time_price, :yearly_price,
      :one_time_currency, :monthly_currency, :yearly_currency
    )
  end
end

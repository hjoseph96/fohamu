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

  def charge_donation
    @donor = Donor.new(donor_attrs)
    @donation = Donation.new(donation_params)

    begin
      exp_month, exp_year = payment_params[:expiry].split('/').map(&:to_i)
      exp_year = "20#{exp_year}".to_i
      @token = Stripe::Token.create({
        card: {
          number: payment_params[:number],
          exp_month: exp_month,
          exp_year: exp_year,
          cvc: payment_params[:cvc],
        }
      })

      @customer = Stripe::Customer.create({
        email: @donor.email,
        source: @token.id
      })
      @donor.customer_id = @customer.id

      @charge = Stripe::Charge.create({
        amount: @donation.price_in_cents,
        currency: @donation.currency,
        customer: @customer.id,
        description: 'FOHAMU Donation',
      })

      if @charge.paid
        if @donor.save!
          @donation.donor_id = @donor.id
          @donation.last_payment_date = DateTime.now
          
          render json: { success: true } if @donation.save!
        end
      end
    rescue Stripe::CardError => e
      render json: { error: e.message }
    end
  end

  def donation_success
  end

  def cancel_donation
  end



  private

  def donation_params
    params.require(:donation).permit(
      :donation_type, :monthly_price, :one_time_price, :yearly_price,
      :one_time_currency, :monthly_currency, :yearly_currency,
      :frequency, :currency, :price_in_cents
    )
  end

  def payment_params
    params.require(:payment).permit(:name, :number, :expiry, :cvc)
  end

  def donor_params
    params.require(:donor).permit(
      :address1, :address2, :city, :state, :zip, :phone_number, :email
    )
  end

  def set_address
    line_one = donor_params[:address1]
    line_two = donor_params[:address2]

    return [line_one, line_two].join(', ') unless line_two.empty?

    line_one
  end

  def donor_attrs
    donor_attrs = donor_params.except(:address1, :address2).to_h
    donor_attrs[:address] = set_address
    donor_attrs[:full_name] = payment_params[:name]
    donor_attrs
  end
end

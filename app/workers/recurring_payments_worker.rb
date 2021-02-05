require 'stripe'

class RecurringPaymentsWorker
  include Sidekiq::Worker
  def perform(*args)

    # do something
  end

  def process_monthly_payments
    @donations = Donation.where(frequency: :monthly)
    @donations.each do |donation|
      time_to_pay = (@donation.last_payment_date + 1.month).past?
      charge_donation(@donation) if (time_to_pay)
    end
  end

  def process_yearly_payments
    @donations = Donation.where(frequency: :yearly)
    @donations.each do |donation|
      time_to_pay = (@donation.last_payment_date + 1.year).past?
      charge_donation(@donation) if (time_to_pay)
    end
  end

  def charge_donation(@donation)
    begin
      @charge = Stripe::Charge.create({
        amount: @donation.price_in_cents,
        currency: @donation.currency,
        customer: @donation.donor.customer_id,
        description: 'FOHAMU Donation',
      })

      send_payment_success_email(@donation.donor) if @charge.paid
    rescue Stripe::CardError => e
      send_payment_error_email(@donation.donor)
    end
  end

  def send_payment_success_email

  end

  def send_payment_error_email

  end
end

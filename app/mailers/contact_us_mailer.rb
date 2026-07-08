class ContactUsMailer < ApplicationMailer
  layout false

  def auto_reply
    @contact = params[:contact]

    mail(to: @contact[:email], subject: 'Thank you for contacting FOHAMU')
  end
end

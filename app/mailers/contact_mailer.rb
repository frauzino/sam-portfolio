class ContactMailer < ApplicationMailer
  default to: ENV["CONTACT_RECIPIENT_EMAIL"]

  def contact_email(contact_form)
    @contact_form = contact_form

    mail(
      from: contact_form.email,
      subject: "New Contact Form Message from #{contact_form.name}"
    )
  end
end

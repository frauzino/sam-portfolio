class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
    @captcha_site_key = ENV['GOOGLE_CAPTCHA_SITE_KEY']
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if verify_recaptcha(model: @contact_form) && @contact_form.valid?
      sleep(1)
      ContactMailer.contact_email(@contact_form).deliver_now
      flash[:notice] = "Thank you for your message, #{@contact_form.name}. I will get back to you soon."
      redirect_to root_path
    else
      flash[:notice] = 'Please fill in all fields correctly and verify the CAPTCHA.'
      render :new, status: :unprocessable_entity
    end
  end


  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :subject, :email, :message)
  end
end

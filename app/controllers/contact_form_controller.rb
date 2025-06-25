# class ContactFormController < ApplicationController
#   def create
#     @name = params[:contact_form][:name]
#     @subject = params[:contact_form][:subject]
#     @email = params[:contact_form][:email]
#     @message = params[:contact_form][:message]

#     sleep(1)
#     flash[:notice] = "Thank you for your message, #{@name}. I will get back to you soon."
#     redirect_to root_path
#   end
# end

class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if @contact_form.valid?
      sleep(1)
      ContactMailer.contact_email(@contact_form).deliver_now
      flash[:notice] = "Thank you for your message, #{@contact_form.name}. I will get back to you soon."
      redirect_to root_path
    else
      flash[:notice] = 'Please fill in all fields correctly.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :subject, :email, :message)
  end
end

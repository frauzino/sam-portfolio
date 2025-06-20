class ContactFormController < ApplicationController
  def create
    @name = params[:contact_form][:name]
    @subject = params[:contact_form][:subject]
    @email = params[:contact_form][:email]
    @message = params[:contact_form][:message]

    sleep(1)
    flash[:notice] = "Thank you for your message, #{@name}. I will get back to you soon."
    redirect_to root_path
  end
end

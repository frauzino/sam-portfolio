class ContactForm
  include ActiveModel::Model

  attr_accessor :name, :subject, :email, :message

  validates :name, :subject, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

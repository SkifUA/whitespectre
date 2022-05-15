class User < ApplicationRecord

  has_one :device
  has_many :temperatures, through: :device

  ## Validations ##
  validates_presence_of :email, :name
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end

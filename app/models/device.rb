class Device < ApplicationRecord
  belongs_to :user
  has_many :temperatures

  ## Validations ##
  validates_presence_of :offset
end

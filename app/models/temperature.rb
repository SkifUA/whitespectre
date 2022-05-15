class Temperature < ApplicationRecord
  LIMIT_FOR_TREND = ENV.fetch('LIMIT_FOR_TREND', 5).freeze
  ALARM_MAGNITUDE = ENV.fetch('ALARM_MAGNITUDE', 37.5).freeze

  belongs_to :device
  has_one :user, through: :device

  ## Validations ##
  validates_presence_of :magnitude, :offset

  ## Scopes ##
  scope :for_trend, -> { order('temperatures.id DESC').limit(LIMIT_FOR_TREND) }

  # TODO add alarm error for incorrect temperature
  def alarm_magnitude?
    magnitude + offset >= ALARM_MAGNITUDE
  end
end

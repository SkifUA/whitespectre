class TemperatureCreator
  attr_reader :temperature, :errors

  def initialize(attr)
    @attr = attr
    @errors = []
  end

  def call
    find_device
    return self unless success?

    add_offset
    create_temperature
    return self unless success?

    send_email if alarm_status?
    self
  end

  def self.call(attr)
    new(attr).call
  end

  def success?
    @errors.empty?
  end

  private

  def add_offset
    @attr[:offset] = @device.offset
  end

  def find_device
    @device = Device.includes(:user).find(@attr[:device_id])
  rescue ActiveRecord::RecordNotFound => e
    @errors << e.message
  end

  def create_temperature
    @temperature = Temperature.create!(@attr)
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid => e
    @errors << e.message
  end

  def alarm_status?
    trend_data = Temperature.where(device_id: @device.id).for_trend
    return false if trend_data.size < Temperature::LIMIT_FOR_TREND

    trend_data.all? { |t| t.alarm_magnitude? }
  end

  def send_email
    UserMailer.with(user: @device.user).alarm_email.deliver_later
  end
end

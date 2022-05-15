class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def alarm_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Trend Temperature Alarm')
  end
end

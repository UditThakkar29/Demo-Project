class SprintMailer < ApplicationMailer
  default from: 'jeerabusiness29@gmail.com'
  layout 'mailer'

  def sprint_end_notification(user:,project:,sprint:)
    @user = user
    @project = project
    @sprint = sprint
    mail(to: @user.email, subject: 'Sprint Ending')
  end
end

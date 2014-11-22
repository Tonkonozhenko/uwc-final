class TicketsMailer < ActionMailer::Base
  default from: 'uwc@tonkonozhenko.com'

  def ticket_email(email, ticket)
    mail(to: email, subject: 'Successful buying')
  end
end

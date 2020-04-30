class ApplicationMailer < ActionMailer::Base
  default from: ENV["mailer_from_address"]
  layout 'mailer'
end

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com'	#默认发件人地址
  layout 'mailer'
end

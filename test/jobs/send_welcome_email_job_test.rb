require_relative '../test_helper'
require 'mail'

class SendWelcomeEmailJobTest < Minitest::Test
  def setup
    Mail::TestMailer.deliveries.clear
    Mail.defaults do
      delivery_method :test
    end
    @user = User.create(name: 'Test User', email: 'test@example.com')
  end

  def test_performs_and_sends_email
    SendWelcomeEmailJob.run(@user.id)
    mail = Mail::TestMailer.deliveries.last
    assert mail, 'No email was sent'
    assert_equal ['test@example.com'], mail.to
    assert_equal 'Welcome to Sinatra Boilerplate!', mail.subject
    assert_includes mail.body.decoded, 'Hello Test User'
  end
end

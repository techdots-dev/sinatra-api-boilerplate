require 'que'
require 'mail'

class SendWelcomeEmailJob < Que::Job
  # args: user_id
  def run(user_id)
    user = User[user_id]
    return unless user

    Mail.deliver do
      to      user.email
      from    'no-reply@example.com'
      subject 'Welcome to Sinatra Boilerplate!'
      body    "Hello #{user.name},\n\nWelcome to our app!"
    end
  end
end

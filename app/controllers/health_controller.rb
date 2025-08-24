class HealthController < Sinatra::Base
  get '/' do
    if request.accept.any? { |a| a.to_s == 'application/json' }
      content_type :json
      status 200
      {
        status: 'ok',
        time: Time.now.utc,
        environment: ENV['RACK_ENV'] || 'development'
      }.to_json
    else
      content_type :text
      status 200
      'ok'
    end
  end
end

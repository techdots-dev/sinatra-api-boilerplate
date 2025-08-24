require_relative '../test_helper'
require 'rack/test'

class HealthApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first
  end

  def test_health_check
    get '/health', {}, { 'Accept' => 'application/json' }
    assert_equal 200, last_response.status
  end
end

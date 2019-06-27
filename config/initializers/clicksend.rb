# Load the gem
require 'clicksend_client'

# Setup authorization
ClickSendClient.configure do |config|
  # Configure HTTP basic authorization: BasicAuth
  config.username = ENV['CLICKSEND_USERNAME']
  config.password = ENV['CLICKSEND_PASSWORD']
end

api_instance = ClickSendClient::AccountApi.new

begin
  #Get account information
  result = api_instance.account_get
  p result
rescue ClickSendClient::ApiError => e
  puts "Exception when calling AccountApi->account_get: #{e}"
end
require 'omniauth/strategies/headquarters'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :headquarters, ENV['HQ_APP_ID'], ENV['HQ_APP_SECRET']
end

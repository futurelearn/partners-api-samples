require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StudentRecruitment
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.x.api_consumer_key = ENV['API_CONSUMER_KEY']
    config.x.api_shared_secret = ENV['API_SHARED_SECRET']
    config.x.webhook_shared_secret = ENV['WEBHOOK_SHARED_SECRET']
  end
end

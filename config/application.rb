require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Saasapp
  class Application < Rails::Application

    # We use a cookie_store for session data
    config.session_store :cookie_store,
                     :key => '_saasapp_session',
                     :domain => :all
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.middleware.use "CustomDomainCookie", ".lvh.me"


  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    require 'sidekiq'
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths << "#{Rails.root}/lib"
    Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }

    config.middleware.use Rack::OAuth2::Server::Rails::Authorize
    config.middleware.use Rack::OAuth2::Server::Resource::Bearer, 'OpenID Connect' do |req|
      AccessToken.valid.find_by(token: req.access_token) ||
      req.invalid_token!
    end
  end
end

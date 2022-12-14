require_relative 'boot'

require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "action_cable/engine"
# require "active_storage/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require 'mongoid'
Mongoid.load!('config/mongoid.yml', Rails.env)

module RealEstate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.orm             :mongoid
    end

    config.mongoid.logger = Logger.new($stdout, :debug)
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.active_job.queue_adapter = :sidekiq
  end
end

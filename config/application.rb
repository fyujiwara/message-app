# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MessageApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.eager_load_paths += %W( #{config.root}/app/services )
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.generators do |g|
      g.test_framework :rspec, {
        routing_specs: false
      }
    end

    # NOTE: Work around
    # failed while executing lib/tasks/auto_generate_diagram.rake:3
    #
    # Generating Entity-Relationship Diagram for n models...
    # rails aborted!
    # NoMethodError: undefined method `parent' for MessageApp::Application:Class
    #
    # RailsERD::Domain#name
    # def name
    #   defined? Rails and Rails.application and Rails.application.class.parent.name
    # end
    class << self
      alias parent module_parent
    end
  end
end

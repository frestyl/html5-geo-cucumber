require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Html5GeoCucumber
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib/rack/geo)
    config.action_view.javascript_expansions[:defaults] = %w()
    config.encoding = "utf-8"
  end
end

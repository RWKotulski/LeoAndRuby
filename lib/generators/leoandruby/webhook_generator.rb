require 'rails/generators'

module LeoAndRuby
  class WebhookGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_controller_file
      copy_file 'leonardo_controller.rb', 'app/controllers/leonardo_controller.rb'
    end

    def add_route
      route "post '/leonardo_webhook', to: 'leonardo#webhook'"
    end

    def create_initializer_file
      template 'leoandruby_initializer.rb', 'config/initializers/leoandruby.rb'
    end
  end
end

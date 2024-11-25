# config/initializers/leoandruby.rb

# Configure the API token for verifying Leonardo.ai webhook requests
LeoAndRuby.config = {
  webhook_token: ENV.fetch('LEONARDO_WEBHOOK_TOKEN', 'your_default_token_here')
}

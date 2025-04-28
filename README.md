# LeoAndRuby

**LeoAndRuby** is a Ruby gem for generating images using the [Leonardo.ai API](https://docs.leonardo.ai/docs/generate-your-first-images). With this gem, you can easily integrate Leonardo.ai's powerful image generation capabilities into your Ruby and Rails applications.

[![Gem Version](https://badge.fury.io/rb/leoandruby.svg)](https://badge.fury.io/rb/leoandruby)

---

## Features

- Generate images using Leonardo.ai's models.
- Retrieve the status and result of a generated image.
- List available models on the Leonardo.ai platform.
- Webhook support to handle asynchronous image generation results.
- Rails generator for setting up webhook integration effortlessly.
- Simple and intuitive Ruby interface for interacting with the Leonardo.ai API.
- Advanced image generation features including Alchemy, PhotoReal, and preset styles.

---

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leoandruby'
```

Then, run:

```bash
bundle install
```

Or install it yourself with:

```bash
gem install leoandruby
```

---

## Setup

To use LeoAndRuby, you need an API key from Leonardo.ai. You can obtain it by signing up for an account and navigating to the API key section in your dashboard.

For Rails users, you can generate a webhook controller and route using the built-in generator.

---

## Usage

### 1. Initialize the Client

Start by creating a client instance with your Leonardo.ai API key:

```ruby
require 'leoandruby'

api_key = 'YOUR_API_KEY'
client = LeoAndRuby::Client.new(api_key)
```

### 2. Generate an Image

You can generate an image by providing the prompt, model ID, width, height, and optionally the number of images:

```ruby
generation_response = client.generate_image(
  prompt: 'An oil painting of a cat',
  model_id: '6bef9f1b-29cb-40c7-b9df-32b51c1f67d3',
  width: 512,
  height: 512,
  num_images: 1, # Optional, defaults to 1 if not specified
  alchemy: true, # Optional, enables Alchemy feature
  photo_real: true, # Optional, enables PhotoReal feature
  photo_real_strength: 0.5, # Optional, controls PhotoReal effect strength (0.0 to 1.0)
  preset_style: 'CINEMATIC' # Optional, applies preset styles
)

generation_id = generation_response['sdGenerationJob']['generationId']
```

### Advanced Image Generation Options

The `generate_image` method supports several advanced options to enhance your image generation:

- `alchemy`: Enable/disable the Alchemy feature for enhanced image quality
- `photo_real`: Enable/disable the PhotoReal feature for photorealistic results
- `photo_real_strength`: Control the strength of the PhotoReal effect (0.0 to 1.0)
- `preset_style`: Apply preset styles like 'CINEMATIC', 'ANIME', 'CREATIVE', etc.

All advanced options are optional and can be used in combination to achieve the desired result.

### 3. List Available Models

You can fetch a list of all available platform models using the `list_models` method:

```ruby
models_response = client.list_models
puts models_response
```

### 4. Retrieve the Generated Image

Wait a few seconds for the image to be generated, then retrieve it using the generation ID:

```ruby
sleep(5)

image_response = client.get_generation(generation_id)
puts image_response
```

---

## Webhook Integration (Rails)

LeoAndRuby supports asynchronous image generation through Leonardo.ai's webhook feature. This allows your application to automatically process results when the image generation is complete.

### Generate a Webhook Controller

Run the following command to generate a controller, route, and initializer for webhook integration:

```bash
rails generate leoandruby:webhook
```

This will:
- Create `app/controllers/leonardo_controller.rb`.
- Add a route to `config/routes.rb`:
  ```ruby
  post '/leonardo_webhook', to: 'leonardo#webhook'
  ```
- Add a configuration file to `config/initializers/leoandruby.rb` for managing the webhook token:
  ```ruby
  LeoAndRuby.config = {
    webhook_token: ENV.fetch('LEONARDO_WEBHOOK_TOKEN', 'your_default_token_here')
  }
  ```

### Webhook Security

The webhook controller verifies requests using an API token provided in the `Authorization` header. Configure your webhook token in an environment variable or directly in the initializer.

Webhook requests without a valid token will be rejected with a `401 Unauthorized` status.

---

## Example Script

Here's a full example script for generating an image and retrieving it:

```ruby
require 'leoandruby'

api_key = 'YOUR_API_KEY'
client = LeoAndRuby::Client.new(api_key)

# Generate an image
generation_response = client.generate_image(
  prompt: 'A futuristic cityscape at sunset',
  model_id: '6bef9f1b-29cb-40c7-b9df-32b51c1f67d3',
  width: 1024,
  height: 768,
  num_images: 1, # Optional, defaults to 1 if not specified
  alchemy: true, # Enable Alchemy for enhanced quality
  photo_real: true, # Enable PhotoReal for photorealistic results
  photo_real_strength: 0.7, # Set PhotoReal strength
  preset_style: 'CINEMATIC' # Apply cinematic style
)

generation_id = generation_response['sdGenerationJob']['generationId']

# Wait for a few seconds
sleep(5)

# Retrieve the generated image
image_response = client.get_generation(generation_id)
puts image_response
```

---

## Configuration

### API Key

You can store your API key in an environment variable for security:

```bash
export LEOANDRUBY_API_KEY=your_api_key
```

Then, retrieve it in your code:

```ruby
api_key = ENV['LEOANDRUBY_API_KEY']
client = LeoAndRuby::Client.new(api_key)
```

### Webhook Token

To secure webhook requests, configure the `LEONARDO_WEBHOOK_TOKEN` environment variable:

```bash
export LEONARDO_WEBHOOK_TOKEN=your_webhook_token
```

---

## Supported Ruby Versions

LeoAndRuby is tested with the latest Ruby versions. Ensure your environment is up to date to avoid compatibility issues.

---

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/RWKotulski/leoandruby). This project is intended to be a safe, welcoming space for collaboration.

---

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

## References

- [Leonardo.ai API Documentation](https://docs.leonardo.ai/)
- [RubyGems Documentation](https://guides.rubygems.org/)

---

## Acknowledgments

Special thanks to [Leonardo.ai](https://leonardo.ai/) for providing such an amazing image generation API.

---
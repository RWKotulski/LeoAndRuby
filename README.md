# LeoAndRuby

**LeoAndRuby** is a Ruby gem for generating images using the [Leonardo.ai API](https://docs.leonardo.ai/docs/generate-your-first-images). With this gem, you can easily integrate Leonardo.ai's powerful image generation capabilities into your Ruby and Rails applications.

[![Gem Version](https://badge.fury.io/rb/leoandruby.svg)](https://badge.fury.io/rb/leoandruby)

---

## Features

- Generate images using Leonardo.ai's models.
- Generate images using user-customized elements.
- Retrieve the status and result of a generated image.
- List available models on the Leonardo.ai platform.
- Fetch user information and custom elements.
- Webhook support to handle asynchronous image generation results.
- Rails generator for setting up webhook integration effortlessly.
- Simple and intuitive Ruby interface for interacting with the Leonardo.ai API.

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
  num_images: 1 # Optional, defaults to 1 if not specified
)

generation_id = generation_response['sdGenerationJob']['generationId']
```

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

### 5. Generate an Image with User Elements

You can generate an image using custom user elements by passing a list of objects containing id and weight:

Example Usage:

```ruby
user_elements = [
  { id: 26060, weight: 0.8 },
  { id: 27868, weight: 1.2 }
]

generation_response = client.generate_image_with_user_elements(
  prompt: "A birthday celebration scene",
  model_id: "SDXL_0_9",
  width: 1024,
  height: 1024,
  presetStyle: "ILLUSTRATION",
  num_images: 1,
  promptMagic: true,
  enhancePrompt: true,
  user_elements: user_elements
)

puts generation_response

```

### 6. Retrieve User Information

To fetch details about the currently authenticated user:

```ruby
user_info = client.me
puts user_info

```

### 7. Retrieve Custom Elements by User ID

To get a list of custom elements associated with a specific user ID:

```ruby
user_id = "12345"
custom_elements = client.get_custom_elements_by_user_id(user_id)
puts custom_elements

```

---

## Webhook Integration (Rails)

LeoAndRuby supports asynchronous image generation through Leonardo.ai’s webhook feature. This allows your application to automatically process results when the image generation is complete.

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
  num_images: 1 # Optional, defaults to 1 if not specified
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
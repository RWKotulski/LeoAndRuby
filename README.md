
# LeoAndRuby

**LeoAndRuby** is a Ruby gem for generating images using the [Leonardo.ai API](https://docs.leonardo.ai/docs/generate-your-first-images). With this gem, you can easily integrate Leonardo.ai's powerful image generation capabilities into your Ruby applications.

[![Gem Version](https://badge.fury.io/rb/leoandruby.svg)](https://badge.fury.io/rb/leoandruby)


---

## Features

- Generate images using Leonardo.ai's models.
- Retrieve the status and result of a generated image.
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

### 3. Retrieve the Generated Image

Wait a few seconds for the image to be generated, then retrieve it using the generation ID:

```ruby
sleep(5)

image_response = client.get_generation(generation_id)
puts image_response
```

---

## Configuration

### Environment Variables

You can store your API key in an environment variable for security:

```bash
export LEOANDRUBY_API_KEY=your_api_key
```

Then, retrieve it in your code:

```ruby
api_key = ENV['LEOANDRUBY_API_KEY']
client = LeoAndRuby::Client.new(api_key)
```

---

## Example Script

Here's a full example script:

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
```


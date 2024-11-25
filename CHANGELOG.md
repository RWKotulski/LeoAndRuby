# Changelog

## [0.4.0] - 2024-11-20
### Added
- **Webhook Support**: Integrated Leonardo.ai's webhook feature to handle asynchronous image generation results. Applications can now automatically process results via a webhook callback.
- **Rails Generator**: Added a generator to set up the webhook integration in Rails applications. This includes:
  - A pre-configured controller (`leonardo_controller.rb`).
  - A route for the webhook (`/leonardo_webhook`).
  - An initializer for managing webhook token configuration.
- **Security Enhancements**: Introduced token-based verification for webhook requests, ensuring only authorized requests are processed.

### Improved
- Enhanced documentation and examples in the README to reflect the new webhook functionality and Rails generator.

---

## [0.3.0] - 2024-11-15
- Added: Ability to list available models from the Leonardo.ai API.
- Improved: General API interaction consistency and better error handling.

---

## [0.2.0] - 2024-11-10
- Added: Support for specifying the number of images in a single generation request.
- Improved: Compatibility with Ruby 3.3.0.

---

## [0.1.0] - 2024-11-01
- Initial release of the LeoAndRuby gem.
- Features:
  - Image generation using Leonardo.ai's API.
  - Retrieve generation results by ID.
  - Basic configuration using environment variables.

---
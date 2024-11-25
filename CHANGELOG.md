
# Changelog

## [0.4.3] - 2024-11-26

- Fixed an issue with the directory structure reference.

## [0.4.2] - 2024-11-26

### Fixed
- Resolved an issue where the Rails generator (`webhook_generator.rb`) was not included in the gem package, causing `LoadError` in Rails applications.

### Added
- Updated `.gemspec` to explicitly include the `lib/generators/**/*` directory, ensuring all generator files are packaged correctly.
- Enhanced documentation for Rails generator usage and clarified the required setup steps.

### Improved
- Added safeguards to prevent similar packaging issues in future releases by ensuring proper gemspec configuration and file verification.

---

## [0.4.1] - 2024-11-26

- Improved: Compatibility with Ruby 3.3.0.


## [0.4.0] - 2024-11-26
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
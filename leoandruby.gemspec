# frozen_string_literal: true

require_relative "lib/leoandruby/version"

Gem::Specification.new do |spec|
  spec.name          = "leoandruby"
  spec.version       = LeoAndRuby::VERSION
  spec.authors       = ["Richard HW Baldwin"]
  spec.email         = ["richard@empireofaustralia.com"]

  spec.summary       = "A Ruby gem for generating AI-powered images with Leonardo.ai's API."
  spec.description   = "LeoAndRuby integrates with the Leonardo.ai API, enabling seamless AI-powered image generation in Ruby and Rails applications with simple, intuitive interfaces."
  spec.homepage      = "https://github.com/RWKotulski/LeoAndRuby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata = {
    "homepage_uri"     => spec.homepage,
    "source_code_uri"  => "https://github.com/RWKotulski/LeoAndRuby",
    "changelog_uri"    => "https://github.com/RWKotulski/LeoAndRuby/CHANGELOG.md",
    "documentation_uri"=> "https://rubydoc.info/gems/leoandruby",
    "bug_tracker_uri"  => "https://github.com/RWKotulski/LeoAndRuby/issues",
    "features"         => <<~FEATURES
      - Generate stunning AI-powered images with minimal configuration.
      - Simple Ruby interface for interacting with the Leonardo.ai API.
      - Supports asynchronous workflows with polling or webhook callbacks.
      - Fully configurable with API key environment variables.
      - Webhook support with Rails generator for seamless integration.
      - Rails 6+ compatible.
    FEATURES
  }

  # Files included in the gem
  gemspec_filename = File.basename(__FILE__)

  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec_filename) ||
      (f.end_with?('.gem')) ||                                  # Exclude any built gem files
      f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  # Add generators explicitly if necessary
  spec.files += Dir.glob("lib/generators/**/*")

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rails", ">= 6.0"

  # (Optional) You could also add 'standard' as development dependency:
  # spec.add_development_dependency "standard", "~> 1.0"
end

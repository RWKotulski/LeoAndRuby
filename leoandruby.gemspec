# frozen_string_literal: true

require_relative "lib/leoandruby/version"

Gem::Specification.new do |spec|
  spec.name = "leoandruby"
  spec.version = Leoandruby::VERSION
  spec.authors = ["Richard HW Baldwin"]
  spec.email = ["richard@empireofaustralia.com"]

  spec.description = "LeoAndRuby is a Ruby gem for integrating with the Leonardo.ai API, enabling seamless image generation within Ruby applications. It provides a simple and intuitive interface for creating, managing, and retrieving AI-generated images."

  spec.summary = "A Ruby gem for generating AI-powered images with Leonardo.ai's API."

  spec.homepage = "https://github.com/RWKotulski/LeoAndRuby"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/RWKotulski/LeoAndRuby",
    "changelog_uri" => "https://github.com/RWKotulski/LeoAndRuby/CHANGELOG.md"
  }

  # Optional, in case you want to highlight features
  spec.metadata["features"] = <<~FEATURES
  - Generate stunning AI-powered images with minimal configuration.
  - Simple Ruby interface for interacting with the Leonardo.ai API.
  - Supports asynchronous workflows with polling for image generation results.
  - Fully configurable with support for API keys via environment variables.
  - Easily integrates into Ruby and Rails applications.
  FEATURES

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://github.com/RWKotulski/LeoAndRuby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

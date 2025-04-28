# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"
require "fileutils"

desc "Run code formatting checks (StandardRB)"
task default: :standard

# Clean up old built gem files
desc "Clean up old built gem files"
task :clean do
  rm_f Dir["leoandruby-*.gem"]
end

# Full release: bump version, commit, tag, push, build, release
desc "Full release: bump, commit, tag, push, build and release gem"
task :full_release, [:bump] => [:standard, :clean] do |t, args|
  bump_type = args[:bump] || "patch" # default to patch bump

  puts "🔧 Bumping #{bump_type} version..."
  bump_version(bump_type)

  version = current_version
  puts "🔖 New version: #{version}"

  puts "✅ Committing version bump..."
  sh "git add lib/leoandruby/version.rb CHANGELOG.md"
  sh "git commit -m 'Bump version to #{version}'"

  puts "🏷️ Tagging release..."
  sh "git tag v#{version}"

  puts "📤 Pushing to GitHub..."
  sh "git push"
  sh "git push --tags"

  puts "📦 Building gem..."
  sh "gem build leoandruby.gemspec"

  puts "🚀 Pushing gem to RubyGems..."
  sh "gem push leoandruby-#{version}.gem"

  puts "🎉 Release v#{version} complete!"
end

# Helpers

def current_version
  File.read("lib/leoandruby/version.rb")[/VERSION\s*=\s*["'](.+)["']/, 1]
end

def bump_version(bump_type)
  file = "lib/leoandruby/version.rb"
  content = File.read(file)

  major, minor, patch = current_version.split(".").map(&:to_i)

  case bump_type
  when "major"
    major += 1
    minor = 0
    patch = 0
  when "minor"
    minor += 1
    patch = 0
  when "patch"
    patch += 1
  else
    raise "Unknown bump type: #{bump_type}. Use major, minor, or patch."
  end

  new_version = "#{major}.#{minor}.#{patch}"

  new_content = content.gsub(/VERSION\s*=\s*["'](.+)["']/, "VERSION = \"#{new_version}\"")
  File.write(file, new_content)

  # Also automatically update CHANGELOG.md
  update_changelog(new_version)
end

def update_changelog(new_version)
  changelog = "CHANGELOG.md"
  timestamp = Time.now.strftime("%Y-%m-%d")

  entry = <<~MARKDOWN

    ## [#{new_version}] - #{timestamp}
    ### Added
    - _Describe new features here._

    ### Changed
    - _Describe changes here._

    ### Fixed
    - _Describe fixes here._
  MARKDOWN

  if File.exist?(changelog)
    content = File.read(changelog)
    updated_content = content.sub(/^# Changelog/, "# Changelog\n#{entry.strip}\n")
    File.write(changelog, updated_content)
    puts "📝 Updated CHANGELOG.md"
  else
    puts "⚠️  CHANGELOG.md not found. Skipping changelog update."
  end
end

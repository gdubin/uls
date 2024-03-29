require "bundler/setup"
require "simplecov"
require 'webmock/rspec'

formatters = []

if ENV['CODECOV_TOKEN']
  require 'codecov'
  formatters << SimpleCov::Formatter::Codecov
end

unless formatters.empty?
  SimpleCov.formatters = formatters
end

SimpleCov.start do
  add_filter '/spec/'
end

require "uls"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

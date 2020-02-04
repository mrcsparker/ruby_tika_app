# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler/setup'

require 'ruby_tika_app'
require 'rspec'

# Include all files under spec/support
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

# Start a local rack server to serve up test pages.
@server_thread = Thread.new do
  Rack::Handler::Thin.run(MyApp::Test::Server.new, Port: 9299, Host: '127.0.0.1')
end

sleep(1) # wait a sec for the server to be booted

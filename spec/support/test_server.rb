require 'rubygems'
require 'rack'

module MyApp
  module Test
    class Server
      def call(env)
        @root = "#{__dir__}/../docs/"
        path = Rack::Utils.unescape(env['PATH_INFO'])
        path += 'index.html' if path == '/'
        file = @root + path.to_s

        if File.exist?(file)
          [200, { 'Content-Type' => 'text/html' }, File.read(file)]
        else
          [404, { 'Content-Type' => 'text/plain' }, 'file not found']
        end
      end
    end
  end
end

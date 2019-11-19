$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'ruby_tika_app'
  s.version     = '1.8.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Chris Parker']
  s.email       = %w[mrcsparker@gmail.com]
  s.homepage    = 'https://github.com/mrcsparker/ruby_tika_app'
  s.summary     = 'Wrapper around the tika-app jar'
  s.description = 'Wrapper around the tika-app jar'

  s.rubyforge_project = 'ruby_tika_app'

  s.files         = `git ls-files`.split("\n") +
                    %w[LICENSE README.md HISTORY]
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = %w[lib]
  s.test_files    = Dir.glob('spec/**/*')

  s.add_runtime_dependency('open4')

  s.add_development_dependency('bundler', '>= 1.0.15')
  s.add_development_dependency('json')
  s.add_development_dependency('pry')
  s.add_development_dependency('rack')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 3.8.0')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('thin')
end

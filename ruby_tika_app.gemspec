# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'ruby_tika_app'
  s.version     = '1.3.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Chris Parker']
  s.email       = %w(mrcsparker@gmail.com)
  s.homepage    = 'https://github.com/mrcsparker/ruby_tika_app'
  s.summary     = %q{Wrapper around the tika-app jar}
  s.description = %q{Wrapper around the tika-app jar}

  s.rubyforge_project = 'ruby_tika_app'

  s.files         = `git ls-files`.split("\n") + 
    %w(LICENSE README.md HISTORY)
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
  s.test_files    = Dir.glob('spec/**/*')

  s.add_runtime_dependency('open4')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 2.13.0')
  s.add_development_dependency('bundler', '>= 1.0.15')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('json')
  s.add_development_dependency('rack')
  s.add_development_dependency('thin')
end

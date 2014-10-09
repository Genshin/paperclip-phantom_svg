Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'paperclip-phantom_svg'
  s.version       = '0.0.4'
  s.license       = 'LGPL-3'
  s.summary       = 'SVG and Raster (primarily PNG) conerters for Paperclip' \
                    ' that don\'t suck so much.'
  s.description   = 'Hight end SVG conversion suite for Paperclip. ' \
                    'Default PaperClip SVG conversion is awful. Using Phantom SVG we can ' \
                    'cross-convert between SVG and PNG with cleaner results and animation ' \
                    'support.'
  s.authors      = ['Rei Kagetsuki']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/phantom_svg-paperclip-processor'

  s.files = `git ls-files`.split($RS)
  s.test_files = s.files.grep(/^spec\//)
  s.require_paths = ['lib']

  s.add_dependency 'paperclip', '~> 4.2'
  s.add_dependency 'phantom_svg', '~> 1.1'

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'activerecord', '~> 4.1'
  s.add_development_dependency 'sqlite3', '~> 1.3'
end

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'paperclip-phantom_svg'
  s.version       = '0.0.2'
  s.license       = 'LGPL-3.0'
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

  s.add_dependency 'paperclip'
  s.add_dependency 'phantom_svg'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
end

require 'paperclip'
require 'paperclip/railtie'
require 'phantom_svg'
require 'rspec'
require 'active_record'

# Connect to sqlite
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Base.logger = Logger.new(nil)
load(File.join(File.dirname(__FILE__), 'schema.rb'))

Paperclip::Railtie.insert

class Document < ActiveRecord::Base
  has_attached_file :original,
    :storage => :filesystem,
    :path => "./spec/tmp/:id.:extension",
    :url => "/spec/tmp/:id.:extension",
    :styles => {
      svg: 'true', px32: '32x32', px128: '128x128'
    },
    :processors => [:phantom_svg]
end

def clear_tmp
  # Dir.entries(Dir.tmpdir).reject{ |x| !(x =~ /base.svg/) }.each do |tempfile|
  #   File.delete(File.join(Dir.tmpdir, tempfile))
  # end
end

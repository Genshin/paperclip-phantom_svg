require 'rspec'
require 'paperclip-phantom_svg'
require 'active_record'

def attachment(options={})
  Paperclip::Attachment.new(:phantom, DummyPhantom.new, options)
end

def fixture_file(filename)
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end

def clear_tmp
  # Dir.entries(Dir.tmpdir).reject{ |x| !(x =~ /base.svg/) }.each do |tempfile|
  #   File.delete(File.join(Dir.tmpdir, tempfile))
  # end
end

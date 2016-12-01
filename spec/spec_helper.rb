require 'rspec'
require 'active_record'
require 'paperclip-phantom_svg'
require 'fileutils'

def attachment(options={})
  Paperclip::Attachment.new(:phantom, DummyPhantom.new, options)
end

def fixture_file(filename)
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end

def tmp_dir_path
  File.dirname(__FILE__) +  '/out'
end

def tmp_dir
  unless File.directory?(tmp_dir_path)
    FileUtils.mkdir_p(tmp_dir_path)
  end
  tmp_dir_path
end

def clear_tmp
  FileUtils.rm_rf(tmp_dir)
end

require 'phantom_svg'
require 'paperclip'

module Paperclip
  # Phantom SVG processor for Paperclip
  class PhantomSVG < Processor
    attr_accessor :src, :options, :attachment
    
    def initialize(file, options = {}, attachment = nil)
      super
      @src = file
      @options = options
      @attachment = attachment
      @basename = File.basename(@file.path, '.*')
    end

    def src_path
      File.expand_path(@src.path)
    end

    def make
      # DO STUFF
    end
  end
end

require 'phantom_svg'
require 'paperclip'

module Paperclip
  # Phantom SVG processor for Paperclip
  class PhantomProcessor < Processor
    attr_accessor :format, :height, :width, :dst
    def initialize(file, options = {}, attachment = nil)
      super
      @src = file
      @options = options
      @format = options[:format] || :svg
      @height = options[:height] || 64
      @width = options[:width] || 64
      @attachment = attachment
      @base_name = File.basename(@file.path, '.*')
      @ouput_name = options[:output_name] || @base_name
      @svg = Phantom::SVG::Base.new(@file.path)
    end

    def make
      Paperclip.log "[PhantomSVG] Making #{@output_name}" if @whiny
      case @format
      when :svg
        return _create_svg
      when :png
        return _create_png
      end
    end

    private

    def _create_svg
      @dst = Tempfile.new([@output_name, '.svg'])
      Paperclip.log "[PhantomSVG] Creating SVG #{@output_name}" if @whiny
      @svg.save_svg(dst.path)
      @dst
    end

    def _create_png
      
    end
  end
end

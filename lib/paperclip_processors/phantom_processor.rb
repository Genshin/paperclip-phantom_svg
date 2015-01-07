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
      @name = options[:output_name] || @base_name
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
      @dst = Tempfile.new([@name, '.svg'])
      Paperclip.log "[PhantomSVG] Creating SVG #{@output_name}" if @whiny
      @svg.save_svg(dst.path)
      @dst
    end

    def _create_png
      @dst = Tempfile.new([@name, '.png'])
      Paperclip.log "[PhantomSVG] Creating SVG #{@output_name} @ #{@height}x#{@width}" if @whiny
      @svg.height = @height if @height
      @svg.width = @width if @width
      @svg.save_apng(@dst.path)
      @dst
    end
  end
end

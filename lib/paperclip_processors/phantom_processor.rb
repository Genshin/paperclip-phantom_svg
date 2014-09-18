require 'phantom_svg'
require 'paperclip'

module Paperclip
  # Phantom SVG processor for Paperclip
  class PhantomProcessor < Processor
    attr_accessor :format, :height, :width, :dst
    def initialize(file, options = {}, attachment = nil)
      super
      @format = options.fetch(:format, :svg)
      @height = options.fetch(:height, 64)
      @width = options.fetch(:width, 64)

      @base_name = File.basename(@file.path, '.*')
      @ouput_name = options.fetch(:output_name, @base_name)
      @svg = Phantom::SVG::Base.new(@file.path)
    end

    def make
      case @format.to_sym
      when  :svg then _create_svg
      when  :png then _create_png
      else
        raise 'Format not supported'
      end
    end

    private

    def _create_svg
      @dst = Tempfile.new([@output_name, '.svg']).tap do |file|
        Paperclip.log "[PhantomSVG] Creating SVG #{@output_name}" if @whiny
        @svg.height = @height if @height
        @svg.width = @width if @width
        @svg.save_svg(file.path)
      end
    end

    def _create_png
      @dst = Tempfile.new([@output_name, '.png']).tap do |file|
        Paperclip.log "[PhantomSVG] Creating SVG #{@output_name} @ #{@height}x#{@width}" if @whiny
        @svg.height = @height if @height
        @svg.width = @width if @width
        @svg.save_apng(file.path)
      end
    end
  end
end

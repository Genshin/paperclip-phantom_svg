require 'phantom_svg'
require 'paperclip'

module Paperclip
  # Phantom SVG processor for Paperclip
  class PhantomSVG < Processor
    attr_accessor :src, :raster_formats, :raster_sizes
    
    def initialize(file, options = {}, attachment = nil)
      super
      @src = file
      @options = options
      @raster_formats = []
      @raster_sizes = []
      _parse_options
      @attachment = attachment
      @base_name = File.basename(@file.path, '.*')
    end

    def src_path
      File.expand_path(@src.path)
    end

    def make
      Paperclip.log "[PhantomSVG] Making #{@file.path}" if @whiny
      _create_base_svg
      _create_pngs if @raster_formats.include? :png
    end

    private

    def _parse_options
      if @options[:formats].include? :png
        @raster_formats << :png
        if @options[:sizes]
          @options[:sizes].each { |size| _parse_size size }
        else # No sizes specified, default to 64px height
          @raster_sizes << { height: 64 }
        end
      end
    end

    def _create_base_svg
    end

    def _create_pngs
    end

    def _parse_size(size)
      if size.is_a? Hash
        @raster_sizes << size if ( size.include?(:height) || size.include?(:width) )
      else
        parsing = size.split('x')
        case parsing.length
        when 1
          @raster_sizes << { height: parsing[0].to_i }
        when 3
          @raster_sizes << { width: parsing[0].to_i, height: parsing[2].to_i }
        when 2
          if parsing[0] == 'x'
            @raster_sizes << { height: parsing[1].to_i }
          else
            @raster_sizes << { width: parsing[0].to_i }
          end
        end
      end
    end
  end
end

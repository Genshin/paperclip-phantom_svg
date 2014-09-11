require 'spec_helper'

describe Paperclip::PhantomSVG do
  before(:all) do
    clear_tmp
  end

  let(:svg_source) { File.new(fixture_file('compiled.svg')) }
  let(:png_source) { File.new(fixture_file('apngasm.png')) }
  let(:test_options) { { formats: [:svg, :png], sizes: {px32: '32x32', 
                                                        px128: { height: 128, width: 128 },
                                                        px64h: '64',
                                                        px16w: '16x',
                                                        px8h: 'x8' } } }

  describe '.new' do
    let(:test_instance) { Paperclip::PhantomSVG.new(svg_source, test_options) }

    it 'properly instantiates' do
      expect(test_instance).to be_an_instance_of(Paperclip::PhantomSVG)
    end

    it 'properly parses format and size options' do
      expect(test_instance.raster_formats).to include(:png)
      expect(test_instance.raster_sizes).to
    end
  end

  context 'with an animated SVG source' do
    let(:svg_processor) { Paperclip::PhantomSVG.new(svg_source, test_options) }

    describe 'create' do
      it 'copies the source SVG as a base, then creates sized PNGs' do
        svg_processor.create
        expect(File.exist?(Dir.pwd + '/spec/dummy/public/px32/compiled.png')).to be_true
      end 
    end
  end
# 
#  # TODO: PNG source
#
#  # TODO: don't save base SVG
#  context 'when processing fails' do
#    describe '.make' do
#      it 'raises an error' do
#        Dir.stub!(:tmpdir).and_return(:raise)
#    
#        lambda {
#          Paperclip::PhantomSVG.new(svg_source, {format: :bmp}).make
#        }.should raise_error(Paperclip::Error)
#      end
#    end
#  end
#
#  context 'with an animated PNG source' do
#    # let(:png_processor) { paperclip::phantomsvg.new(png_source, test_options) }
end

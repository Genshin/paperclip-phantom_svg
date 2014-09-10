require 'spec_helper'

describe Paperclip::PhantomSVG do
  before(:all) do
    clear_tmp
  end

  let(:svg_source) { fixture_file 'compiled.svg' }
  let(:png_source) { fixture_file 'apngasm.png' }
  let(:tets_options) { { formats: [:svg, :png], sizes: {px32: '32x32', px128: '128x128' } } }

  describe '.new' do
    it 'properly instantiates' do
      expect(Paperclip::PhantomSVG.new(svg_source, test_options)).to be_an_instance_of(Paperclip::PhantomSVG)
    end
  end

  context 'with an animated SVG source' do
    let(:svg_processor) { paperclip::phantomsvg.new(svg_source, test_options) }

#    describe '.make' do
#      it 'copies the source SVG as a base, then creates sized PNGs' do
#        svg_processor.make
#      end 
#    end
#  end
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
#  end
end

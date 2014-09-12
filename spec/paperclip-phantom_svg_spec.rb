require 'spec_helper'

describe Paperclip::PhantomProcessor do
  before(:all) do
    clear_tmp
  end

  let(:svg_source) { File.new(fixture_file('compiled.svg')) }
  let(:png_source) { File.new(fixture_file('apngasm.png')) }
  let(:test_options_svg) { { output_name: 'test_svg', format: :svg } }
  let(:test_options_png) { { output_name: 'test_png', format: :png, height: 128, width: 128 } }
  let(:test_options_png_h) { { output_name: 'test_png_h', format: :png, height: 64 } }

  describe '.new' do
    let(:test_instance) { Paperclip::PhantomProcessor.new(svg_source, test_options_png) }

    it 'properly instantiates' do
      expect(test_instance).to be_an_instance_of(Paperclip::PhantomProcessor)
    end

    it 'properly parses format and size options' do
      expect(test_instance.format).to be(:png)
      expect(test_instance.height).to be(128)
    end
  end

  context 'with an animated SVG source' do
    let(:svg_processor) { Paperclip::PhantomProcessor.new(svg_source, test_options_svg) }

    describe '.make' do
      clear_tmp
      it 'copies the source SVG as a base, then creates sized PNGs' do
        expect(svg_processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(svg_processor.dst.path)
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

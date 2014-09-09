require 'spec_helper'

describe Paperclip::PhantomSVG do

  let png_source do
    File.open './fixtures/apngasm.png'
  end

  let svg_source do
    File.open './fixtures/compiled.svg'
  end

  before(:all) do
    clear_tmp
  end

  context 'with an animated SVG source' do
    before(:all) do
      @options = {formats: [:svg, :png], sizes: {px32: 32, px128: 128}
      @processor = Paperclip::PhantomSVG.new(svg_source, @options)
    end

    describe '.make' do
      it 'copies the source SVG as a base, then creates sized PNGs' do

        @processor.make
      end 
    end
  end
 
  # TODO: PNG source

  # TODO: don't save base SVG
  context 'when processing fails' do
    describe '.make' do
      it 'raises an error' do
        Dir.stub!(:tmpdir).and_return(:raise)
    
        lambda {
          Paperclip::PhantomSVG.new(svg_source, {format: :bmp}).make
        }.should raise_error(Paperclip::Error)
      end
    end
  end
end

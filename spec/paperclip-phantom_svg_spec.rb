require 'spec_helper'

describe Paperclip::PhantomProcessor do
  before(:all) do
    clear_tmp
    FileUtils::mkdir_p 'tmp/'
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
    describe '.make({format: :svg})' do
      it 'saves an SVG from an SVG' do
        processor = Paperclip::PhantomProcessor.new(svg_source, test_options_svg)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end

    describe '.make({format: :png, height: 128, width: 128})' do
      it 'saves a PNG from an SVG' do
        processor = Paperclip::PhantomProcessor.new(svg_source, test_options_png)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end

    describe '.make({format: :png, height: 64})' do
      it 'saves a PNG with height only specefied from an SVG' do
        processor = Paperclip::PhantomProcessor.new(svg_source, test_options_png_h)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end
  end
  
  context 'with an animated PNG source' do
    describe '.make({format: :svg})' do
      it 'saves an SVG from a PNG' do
        processor = Paperclip::PhantomProcessor.new(png_source, test_options_svg)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end

    describe '.make({format: :png, height: 128, width: 128})' do
      it 'saves a PNG from an PNG' do
        processor = Paperclip::PhantomProcessor.new(png_source, test_options_png)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end

    describe '.make({format: :png, height: 64})' do
      it 'saves a PNG with only height specified from a PNG' do
        processor = Paperclip::PhantomProcessor.new(png_source, test_options_png_h)
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end

    describe '.make({format: :png, height: 12, width: 12})' do
      it 'saves a small PNG from a PNG' do
        processor = Paperclip::PhantomProcessor.new(png_source,
                                                    { format: :png, height: 12, width: 12 })
        expect(processor.make).to be_an_instance_of(Paperclip::Tempfile)
        expect(File).to exist(processor.dst.path)
        FileUtils.copy(processor.dst.path, 'tmp/')
      end
    end
  end
end

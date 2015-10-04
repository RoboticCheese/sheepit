require_relative '../../spec_helper'
require_relative '../../../lib/sheepit/changelog/base'

describe Sheepit::Changelog::Base do
  let(:changelog) { described_class.new }

  describe '.from_file' do
    let(:changelog) { described_class.from_file }

    before(:each) do
      allow(File).to receive(:open).with(File.expand_path('CHANGELOG.md'))
        .and_return(double(read: 'a changelog'))
      allow(described_class).to receive(:from_s)
    end

    it 'defaults the path to "CHANGELOG.md"' do
      expect(File).to receive(:open).with(File.expand_path('CHANGELOG.md'))
      changelog
    end

    it 'uses `.from_s` to generate a new changelog object' do
      expect(described_class).to receive(:from_s).with('a changelog')
      changelog
    end
  end

  describe '.from_s' do
    let(:changelog) { described_class.from_s('a changelog') }

    it 'raises an error' do
      expect { changelog }.to raise_error(NotImplementedError)
    end
  end

  describe '#to_file' do
    let(:file) { double(write: true) }

    before(:each) do
      allow(File).to receive(:open).with(File.expand_path('CHANGELOG.md'))
        .and_yield(file)
      allow_any_instance_of(described_class).to receive(:to_s)
        .and_return('a changelog')
    end

    it 'defaults the path to "CHANGELOG.md"' do
      expect(File).to receive(:open).with(File.expand_path('CHANGELOG.md'))
      changelog.to_file
    end

    it 'uses `.to_s` to generate new changelog file content' do
      expect(file).to receive(:write).with('a changelog')
      changelog.to_file
    end
  end

  describe '#to_s' do
    it 'raises an error' do
      expect { changelog.to_s }.to raise_error(NotImplementedError)
    end
  end
end

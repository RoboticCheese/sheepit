require_relative '../spec_helper'
require_relative '../../lib/sheepit/changelog'

describe Sheepit::Changelog do
  let(:title) { nil }
  let(:changesets) { nil }
  let(:changelog) { described_class.new(title, changesets) }

  describe '.from_file' do
    let(:path) { File.expand_path('../../data/CHANGELOG.md', __FILE__) }
    let(:changelog) { described_class.from_file(path) }

    it 'returns a Changelog object' do
      expect(changelog).to be_an_instance_of(described_class)
    end

    it 'correctly parses the changelog file' do
      c = changelog
      expect(c.title).to eq('Sheepit Gem CHANGELOG')
      expect(c.changesets.length).to eq(2)
    end
  end

  describe '.from_str' do
    let(:body) do
      <<-EOH.gsub(/^ +/, '')
        Sheepit Gem CHANGELOG
        =====================

        v0.1.0 (2015-09-01)
        -------------------
        - Initial release
        - Support pants

        v0.0.1 (2015-08-01)
        -------------------
        - Development started
      EOH
    end
    let(:changelog) { described_class.from_str(body) }

    it 'returns a Changelog object' do
      expect(changelog).to be_an_instance_of(described_class)
    end

    it 'correctly parses the changelog string' do
      c = changelog
      expect(c.title).to eq('Sheepit Gem CHANGELOG')
      expect(c.changesets.length).to eq(2)
    end
  end

  describe '.initialize' do
    let(:title) { 'Some Stuff' }
    let(:changesets) do
      [Sheepit::Changelog::Changeset.new('1.2.3', '2015-09-01', ['A change'])]
    end

    it 'stores the changelog title' do
      expect(changelog.instance_variable_get(:@title)).to eq(title)
    end

    it 'stores the changelog changesets' do
      expect(changelog.instance_variable_get(:@changesets)).to eq(changesets)
    end
  end
end

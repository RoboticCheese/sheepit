require_relative '../../spec_helper'
require_relative '../../../lib/sheepit/changelog/changeset'

describe Sheepit::Changelog::Changeset do
  let(:version) { nil }
  let(:date) { nil }
  let(:changes) { nil }
  let(:changeset) { described_class.new(version, date, changes) }

  describe '.from_str' do
    let(:body) do
      <<-EOH.gsub(/^ +/, '')
        v0.1.0 (2015-09-01)
        -------------------
        - Do some things
        - Do some other things
      EOH
    end
    let(:changeset) { described_class.from_str(body) }

    it 'returns a Changeset object' do
      expect(changeset).to be_an_instance_of(described_class)
    end

    it 'correctly parses the changeset body' do
      c = changeset
      expect(c.version).to eq('0.1.0')
      expect(c.date).to eq('2015-09-01')
      expect(c.changes.length).to eq(2)
      expect(c.changes[0].description).to eq('Do some things')
    end
  end

  describe '#initialize' do
    let(:version) { '1.2.3' }
    let(:date) { '2015-10-21' }
    let(:changes) { ['Some stuff', 'Some more stuff', 'Even more stuff'] }

    it 'initializes the version instance variable' do
      expect(changeset.instance_variable_get(:@version)).to eq('1.2.3')
    end

    it 'initializes the date instance variable' do
      expect(changeset.instance_variable_get(:@date)).to eq('2015-10-21')
    end

    it 'initializes the changes instance variable' do
      changes = changeset.instance_variable_get(:@changes)
      expect(changes).to be_an_instance_of(Array)
      expect(changes.length).to eq(3)
      expect(changes[0].to_s).to eq('- Some stuff')
      expect(changes[1].to_s).to eq('- Some more stuff')
      expect(changes[2].to_s).to eq('- Even more stuff')
    end
  end

  describe '#version' do
    let(:version) { '1.2.3' }
    let(:date) { '2015-10-21' }
    let(:changes) { ['Some stuff', 'Some more stuff', 'Even more stuff'] }

    it 'returns the version' do
      expect(changeset.version).to eq('1.2.3')
    end
  end

  describe '#date' do
    let(:version) { '1.2.3' }
    let(:date) { '2015-10-21' }
    let(:changes) { ['Some stuff', 'Some more stuff', 'Even more stuff'] }

    it 'returns the date' do
      expect(changeset.date).to eq('2015-10-21')
    end
  end

  describe '#changes' do
    let(:version) { '1.2.3' }
    let(:date) { '2015-10-21' }
    let(:changes) { ['Some stuff', 'Some more stuff', 'Even more stuff'] }

    it 'returns the changes' do
      expect(changeset.changes).to be_an_instance_of(Array)
      expect(changeset.changes.length).to eq(3)
      expect(changeset.changes[0].to_s).to eq('- Some stuff')
      expect(changeset.changes[1].to_s).to eq('- Some more stuff')
      expect(changeset.changes[2].to_s).to eq('- Even more stuff')
    end
  end

  describe '#to_s' do
    let(:version) { '1.2.3' }
    let(:date) { '2015-10-21' }
    let(:changes) { ['Some stuff', 'Some more stuff', 'Even more stuff'] }

    it 'returns the expected string' do
      expected = <<-EOH.gsub(/^ {8}/, '').strip
        v1.2.3 (2015-10-21)
        -------------------
        - Some stuff
        - Some more stuff
        - Even more stuff
      EOH
      expect(changeset.to_s).to eq(expected)
    end
  end
end

require_relative '../spec_helper'
require_relative '../../lib/sheepit/changelog'

describe Sheepit::Changelog do
  describe '.for_plugin' do
    let(:changelog) { described_class.for_plugin(:base) }

    it 'returns an instance of Changelog::Base' do
      expect(changelog).to be_an_instance_of(Sheepit::Changelog::Base)
    end
  end
end

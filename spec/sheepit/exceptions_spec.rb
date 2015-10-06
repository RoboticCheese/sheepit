require_relative '../spec_helper'
require_relative '../../lib/sheepit/exceptions'

describe Sheepit::Exceptions do
  describe Sheepit::Exceptions::ConfigMissing do
    describe '.initialize' do
      it 'complains about a missing key' do
        expected = '`key1` config key cannot be nil!'
        expect(described_class.new(:key1).message).to eq(expected)
      end
    end
  end
end

require_relative '../../../spec_helper'
require_relative '../../../../lib/sheepit/changelog/standard/change'

describe Sheepit::Changelog::Standard::Change do
  let(:description) { 'a new change' }
  let(:change) { described_class.new(description) }

  describe 'BULLET' do
    it 'returns a single dash' do
      expect(described_class::BULLET).to eq('-')
    end
  end

  describe '.initialize' do
    context 'a valid description' do
      let(:description) { 'a new change' }

      it 'saves the description' do
        expect(change.description).to eq(description)
      end
    end

    context 'a nil description' do
      let(:description) { nil }

      it 'raises an error' do
        pending
        expect { change }.to raise_error(ArgumentError)
      end
    end

    context 'a symbol description' do
      it 'raises an error' do
        pending
        expect { change }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#to_s' do
    context 'a short description' do
      let(:description) { 'a new change' }

      it 'returns the change body as a Markdown bullet point' do
        expect(change.to_s).to eq('- a new change')
      end
    end

    context 'a >80-character description' do
      let(:description) { ('alpha beta gamma delta ' * 10).strip }

      it 'splits the change over multiple lines' do
        expected = '- alpha beta gamma delta alpha beta gamma delta alpha ' \
                   "beta gamma delta alpha\n  beta gamma delta alpha beta " \
                   "gamma delta alpha beta gamma delta alpha beta\n  gamma " \
                   'delta alpha beta gamma delta alpha beta gamma delta ' \
                   "alpha beta gamma\n  delta"
        expect(change.to_s).to eq(expected)
      end
    end

    context 'a >80-character, single-world description' do
      let(:description) { 'abcd' * 30 }

      it 'splits the change over multiple lines' do
        expected = '- abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdab' \
                   'cdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdab' \
                   'cdabcdabcd'
        expect(change.to_s).to eq(expected)
      end
    end
  end
end

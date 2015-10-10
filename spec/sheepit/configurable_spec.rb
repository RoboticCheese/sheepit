require_relative '../spec_helper'
require_relative '../../lib/sheepit/configurable'

describe Sheepit::Configurable do
  let(:test_class) do
    Class.new do
      include Sheepit::Configurable
    end
  end
  let(:config) { nil }
  let(:test_obj) { test_class.new(config) }

  describe '.included' do
    let(:base) { double }

    it 'extends ClassMethods' do
      expect(base).to receive(:extend).with(described_class::ClassMethods)
      described_class.included(base)
    end
  end

  describe '#initialize' do
    context 'no config param' do
      let(:test_obj) { test_class.new }

      it 'saves an empty config hash' do
        expect(test_obj.config).to eq({})
      end
    end

    context 'a nil config param' do
      let(:config) { nil }

      it 'saves an empty config hash' do
        expect(test_obj.config).to eq({})
      end
    end

    context 'a populated config param' do
      let(:test_class) do
        Class.new do
          include Sheepit::Configurable
          default_config :thing, nil
        end
      end

      let(:config) { { thing: 'stuff' } }

      it 'saves the config hash' do
        expect(test_obj.config).to eq(config)
      end
    end
  end

  describe '#build_config!' do
    let(:test_class) do
      Class.new do
        include Sheepit::Configurable
        default_config :key1, 'value1'
      end
    end
    let(:config) { {} }

    context 'no overridden defaults' do
      let(:config) { {} }

      it 'returns the defaults' do
        expect(test_obj.build_config!(config)[:key1]).to eq('value1')
      end
    end

    context 'overridden defaults' do
      let(:config) { { key1: 'othervalue' } }

      it 'returns the overrides' do
        expect(test_obj.build_config!(config)[:key1]).to eq('othervalue')
      end
    end
  end

  describe '#validate_config!' do
    let(:test_class) do
      Class.new do
        include Sheepit::Configurable
        required_config :thing1
      end
    end

    context 'a valid config' do
      let(:config) { { thing1: 'test' } }

      it 'passes' do
        expect(test_obj.validate_config!).to eq(config)
      end
    end

    context 'an invalid config missing a required key' do
      let(:config) { {} }

      it 'raises an error' do
        expected = Sheepit::Exceptions::ConfigMissing
        expect { test_obj.validate_config!(config) }.to raise_error(expected)
      end
    end

    context 'an invalid config with an unrecognized config key' do
      let(:config) { { thing2: 'bad' } }

      it 'raises an error' do
        expected = Sheepit::Exceptions::InvalidConfig
        expect { test_obj.validate_config!(config) }.to raise_error(expected)
      end
    end
  end

  describe '#config' do
    it 'returns an empty Hash' do
      expect(test_obj.send(:config)).to eq({})
    end
  end

  describe described_class::ClassMethods do
    describe '.required_config' do
      let(:test_class) do
        Class.new do
          include Sheepit::Configurable
          required_config :key1
        end
      end

      it 'saves a required key for later' do
        expect(test_class.required).to eq([:key1])
      end
    end

    describe '.default_config' do
      let(:test_class) do
        Class.new do
          include Sheepit::Configurable
          default_config :key1, 'value1'
        end
      end

      it 'saves a default key and value for later' do
        expect(test_class.defaults).to eq(key1: 'value1')
      end
    end

    describe '.required' do
      context 'a fresh class' do
        it 'returns an empty Array' do
          expect(test_class.required).to eq([])
        end
      end

      context 'a class with some required items set' do
        let(:test_class) do
          Class.new do
            include Sheepit::Configurable
            required_config :test1
          end
        end

        it 'returns the required items' do
          expect(test_class.required).to eq([:test1])
        end
      end
    end

    describe '.defaults' do
      context 'a freshly initialized object' do
        it 'returns an empty Hash' do
          expect(test_class.defaults).to eq({})
        end
      end

      context 'an object with some defaults set' do
        let(:test_class) do
          Class.new do
            include Sheepit::Configurable
            default_config :thing1, 'test'
          end
        end

        it 'returns the defaults' do
          expect(test_class.defaults).to eq(thing1: 'test')
        end
      end
    end

    describe '.configure!' do
      it 'saves a new class instance in a class variable' do
        c = test_class
        expect(c.configure!).to be_an_instance_of(c)
      end
    end
  end
end

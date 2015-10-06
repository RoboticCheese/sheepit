# Encoding: UTF-8
#
# Author:: Jonathan Hartman (<j@hartman.io>)
#
# Copyright (C) 2015 Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative 'exceptions'

module Sheepit
  # A mixin that other classes can include to implement certain configuration
  # niceties. Based partly on Test Kitchen's Configurable module
  # (https://github.com/test-kitchen/test-kitchen/blob/master/lib/kitchen/
  # configurable.rb), but simplified for use in this application.
  #
  # @author Jonathan Hartman <j@hartman.io>
  module Configurable
    #
    # Use the .included hook to pull in ClassMethods and make all its methods
    # accessible on the class level.
    #
    def self.included(base)
      base.extend(ClassMethods)
    end

    #
    # Initialize based on a config hash and save it as an instance variable.
    #
    def initialize(config = {})
      @config = build_config(config || {})
    end

    #
    # Perform validation against a configuration hash and then assign any
    # default values to non-existent keys.
    #
    # @param config [Hash] a configuration Hash
    #
    def build_config(config)
      validate_config(config)
      self.class.defaults.each { |k, v| config[k] ||= v }
      config
    end

    #
    # Iterate over any config validation that needs to be done and do it to a
    # provided config Hash.
    #
    # @param config [Hash] a configuration Hash
    #
    # @raise [ConfigError] if a config key validation fails
    #
    def validate_config(config)
      self.class.required.each do |r|
        fail(Exceptions::ConfigMissing, r) if config[r].nil?
      end
      self
    end

    # @return [Hash] a configuration Hash
    attr_reader :config

    # The subset of methods to be used, DSL-style, in a Configurable class.
    #
    # @author Jonathan Hartman <j@hartman.io>
    module ClassMethods
      #
      # Declare a config key that is required (i.e. must be non-nil) for use
      # at validation time.
      #
      # @param key [Symbol] a required configuration key
      #
      def required_config(key)
        required << key
      end

      #
      # Declare a default value for a specified config key.
      #
      # @param key [Symbol] a configuration key to assign a default to
      # @param value the value to assign to this config key
      #
      def default_config(key, value)
        defaults[key] = value
      end

      #
      # An Array in which we can store config keys that are required, for the
      # validation phase to iterate over.
      #
      # @return [Array] a list of config keys
      #
      def required
        @required ||= []
      end

      #
      # A Hash of default configuration keys and their values.
      #
      # @return [Hash] a Hash of defaults
      #
      def defaults
        @defaults ||= {}
      end

      #
      # Provide a class .configure! method for singleton classes that saves
      # an instance of the class in @instance that can then be used by other
      # class methods.
      #
      # @param config [Hash] a configuration Hash
      #
      def configure!(config = {})
        @instance = new(config || {})
      end
      attr_reader :instance
    end
  end
end

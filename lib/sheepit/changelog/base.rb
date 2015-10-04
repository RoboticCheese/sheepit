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

module Sheepit
  # A base changelog class for all others to inherit from. A proper changelog
  # plugin is required to define its own `self.from_s` and `to_s` methods.
  #
  # @author Jonathan Hartman <j@hartman.io>
  class Changelog
    class Base
      class << self
        #
        # Initialize a new Changelog object based on a file.
        #
        # @param path [String] the path to a changelog file
        #
        # @return [Changelog] a Changelog object based on the contents of a file
        #
        def from_file(path = 'CHANGELOG.md')
          from_s(File.open(File.expand_path(path)).read)
        end

        #
        # Initialize a new Changelog object based on a string. This method must
        # be defined by each individual changelog plugin.
        #
        # @param body [String] the changelog body to parse
        #
        # @return [Changelog] a Changelog object based on a string
        #
        def from_s(body)
          fail(NotImplementedError,
               "`.from_s` method must be implemented by '#{self.class}' plugin")
        end
      end

      #
      # Write the string representation of the current changelog to a file.
      #
      # @param path [String] the path to a changelog file.
      #
      def to_file(path = 'CHANGELOG.md')
        File.open(File.expand_path(path)) { |f| f.write(to_s) }
      end

      #
      # Render the current changelog object as a string. This method must be
      # defined by each individual changelog plugin.
      #
      # @return [String] a string representation of the changelog.
      #
      def to_s
        fail(NotImplementedError,
             "`#to_s` method must be implemented by '#{self.class}' plugin")
      end
    end
  end
end

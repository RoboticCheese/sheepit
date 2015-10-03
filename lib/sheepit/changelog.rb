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

require_relative 'changelog/changeset'

module Sheepit
  # A base changelog class
  #
  # @author Jonathan Hartman <j@hartman.io>
  class Changelog
    class << self
      #
      # Initialize a new Changelog object based on a file.
      #
      # @param path [String] the path to a changelog file
      #
      # @return [Changelog] a Changelog object based on the contents of a file
      #
      def from_file(path = 'CHANGELOG.md')
        from_str(File.open(File.expand_path(path)).read)
      end

      #
      # Initialize a new Changelog object based on a string.
      #
      # @param body [String] the changelog body to parse
      #
      # @return [Changelog] a Changelog object based on a string
      #
      def from_str(body)
        title = body.lines[0].strip
        changesets = body.split("\n\n")[1..-1].map { |c| Changeset.from_str(c) }
        self.new(title, changesets)
      end
    end

    attr_reader :title, :changesets

    #
    # Initialize a new Changelog object.
    #
    # @param title [String] the project title
    # @param changesets [Array<Changeset] the project changesets
    #
    # @return [Changelog] a Changelog object based on a string
    #
    def initialize(title, changesets)
      @title = title
      @changesets = changesets
    end
  end
end

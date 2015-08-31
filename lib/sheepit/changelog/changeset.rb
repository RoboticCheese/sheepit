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

require_relative 'change'

module Sheepit
  class Changelog
    # A class to represent a single changeset, which will include:
    #   * A version number
    #   * A date string
    #   * A set of changes (array of strings)
    #
    # @author Jonathan Hartman <j@hartman.io>
    class Changeset
      attr_reader :version, :date, :changes

      #
      # Initialize a Changeset object with a version, date, and set of changes.
      #
      # @param version [String] a version string
      # @option date [String] a date string (defaults to today)
      # @option changes [Array] an array of change strings (defaults to empty)
      #
      # @return [Changeset] the new Changeset object
      #
      def initialize(version, date, changes)
        @version = version
        @date = date
        @changes = changes.map { |c| Change.new(c) }
      end

      #
      # Render the changeset as a Markdown string.
      #
      # @return [String] the changeset, ready to be dumped into a .md file
      #
      def to_s
        lines = ["v#{version} (#{date})"]
        lines << '-' * lines[0].length
        (lines + changes).join("\n")
      end
    end
  end
end

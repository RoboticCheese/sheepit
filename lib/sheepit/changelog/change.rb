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
  class Changelog
    # A class representing a single change.
    #
    # @author Jonathan Hartman <j@hartman.io>
    class Change
      BULLET = '-'

      attr_reader :description

      #
      # Iniitalize a new Change object based on a given description.
      #
      # @param description [String] a brief description of the change
      #
      # @return [Change] the new Change object
      def initialize(description)
        @description = description
      end

      #
      # Render the change as a Markdown string, with a leading bullet character
      # and split up into <80-character lines.
      #
      # @return [String] the change, ready to be dumped into a .md file
      #
      def to_s
        # A 79-character line can have up to 77 characters of description and 2
        # of '- ' or indentation.
        lines = [description.split[0]]
        description.split[1..-1].each do |word|
          if (lines.last + ' ' + word).length <= 77
            lines.last << ' ' << word
          else
            lines << word
          end
        end
        res = lines.join("\n  ")
        '- ' << res
      end
    end
  end
end

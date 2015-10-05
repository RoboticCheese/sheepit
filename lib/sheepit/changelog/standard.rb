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

require_relative '../changelog'
require_relative 'base'
require_relative 'standard/changeset'
require_relative 'standard/change'

module Sheepit
  class Changelog
    # A standard default changelog class.
    #
    # @author Jonathan Hartman <j@hartman.io>
    class Standard < Base
      class << self
        #
        # Initialize a new Changelog object based on a string.
        #
        # (see Sheepit::Changelog::Base.from_s)
        #
        def from_s(body)
          title = body.lines[0].strip
          changesets = body.split("\n\n")[1..-1].map do |c|
            Changeset.from_str(c)
          end
          self.new(title, changesets)
        end
      end
    end
  end
end

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
  # The changelog component control's a project's changelog file, reading and
  # writing its contents, with different formats of changelogs supported by
  # different plugins.
  #
  # @author Jonathan Hartman <j@hartman.io>
  class Changelog
    class << self
      # Return a new instance of a changelog class for a given plugin.
      #
      # @param plugin [Symbol] a driver plugin
      # @return [Changelog::Base] a new changelog instance for the given plugin
      def for_plugin(plugin, config = {})
        first_load = require("sheepit/changelog/#{plugin}")
        klass = const_get(Thor::Util.camel_calse(plugin))
        object = klass.new(config)
        object.verify_dependencies if first_load
        object
      end
    end
  end
end

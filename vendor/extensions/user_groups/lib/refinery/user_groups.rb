require 'refinerycms-core'

module Refinery
  autoload :UserGroupsGenerator, 'generators/refinery/user_groups_generator'

  module UserGroups
    require 'refinery/user_groups/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end

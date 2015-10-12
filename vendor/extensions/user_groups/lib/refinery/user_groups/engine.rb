module Refinery
  module UserGroups
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::UserGroups

      engine_name :refinery_user_groups

      initializer "register refinerycms_user_groups plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "user_groups"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.user_groups_admin_user_groups_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/user_groups/user_group',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::UserGroups)
      end
    end
  end
end

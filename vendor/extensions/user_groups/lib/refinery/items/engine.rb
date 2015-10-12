module Refinery
  module UserGroups
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::UserGroups

      engine_name :refinery_user_groups

      initializer "register refinerycms_items plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "items"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.user_groups_admin_items_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/user_groups/item'
          }
          plugin.menu_match = %r{refinery/user_groups/items(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Items)
      end
    end
  end
end

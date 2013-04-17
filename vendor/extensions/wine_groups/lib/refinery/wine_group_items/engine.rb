module Refinery
  module WineGroups
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::WineGroups

      engine_name :refinery_wine_groups

      initializer "register refinerycms_wine_group_items plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "wine_group_items"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.wine_groups_admin_wine_group_items_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/wine_groups/wine_group_item'
          }
          plugin.menu_match = %r{refinery/wine_groups/wine_group_items(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::WineGroupItems)
      end
    end
  end
end

module Refinery
  module WineGroups
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::WineGroups

      engine_name :refinery_wine_groups

      initializer "register refinerycms_wine_groups plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "wine_groups"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.wine_groups_admin_wine_groups_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/wine_groups/wine_group',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::WineGroups)
      end
    end
  end
end

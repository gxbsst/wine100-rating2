module Refinery
  module Wines
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Wines

      engine_name :refinery_wines

      initializer "register refinerycms_wines plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "wines"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.wines_admin_wines_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/wines/wine',
            :title => 'name_zh'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Wines)
      end
    end
  end
end

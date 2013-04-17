module Refinery
  module Styles
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Styles

      engine_name :refinery_wines

      initializer "register refinerycms_styles plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "styles"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.styles_admin_styles_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/styles/style',
            :title => 'name'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Styles)
      end
    end
  end
end

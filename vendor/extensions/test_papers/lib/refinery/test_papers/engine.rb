module Refinery
  module TestPapers
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::TestPapers

      engine_name :refinery_test_papers

      initializer "register refinerycms_test_papers plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "test_papers"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.test_papers_admin_test_papers_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/test_papers/test_paper',
            :title => 'score'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::TestPapers)
      end
    end
  end
end

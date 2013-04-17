module Refinery
  module Wines
    module Admin
      class WinesController < ::Refinery::AdminController

        crudify :'refinery/wines/wine',
                :title_attribute => 'name_zh', :xhr_paging => true

      end
    end
  end
end

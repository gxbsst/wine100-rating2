module Refinery
  module WineGroups
    module Admin
      class WineGroupItemsController < ::Refinery::AdminController

        crudify :'refinery/wine_groups/wine_group_item', :xhr_paging => true

      end
    end
  end
end

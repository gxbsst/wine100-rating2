module Refinery
  module WineGroups
    module Admin
      class WineGroupsController < ::Refinery::AdminController

        crudify :'refinery/wine_groups/wine_group',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end

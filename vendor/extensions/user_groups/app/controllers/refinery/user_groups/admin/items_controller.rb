module Refinery
  module UserGroups
    module Admin
      class ItemsController < ::Refinery::AdminController

        crudify :'refinery/user_groups/item', :xhr_paging => true

      end
    end
  end
end

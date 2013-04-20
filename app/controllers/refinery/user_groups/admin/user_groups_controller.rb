module Refinery
  module UserGroups
    module Admin
      class UserGroupsController < ::Refinery::AdminController

        crudify :'refinery/user_groups/user_group',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end

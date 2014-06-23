module Refinery
  module Members
    module Admin
      class MembersController < ::Refinery::AdminController

        crudify :'refinery/members/member',
                :title_attribute => 'name', :xhr_paging => true

        def export_e_group
          @members = ::User.where(:role => 'e_group')
          render  :xlsx => 'export_e_group_note',:filename =>  "e_group_date", :disposition =>  'inline'

        end

        def export_member_note
          @members = ::User.where(:id => params[:member_ids])
          render  :xlsx => 'export_user_notes',:filename =>  "user_notes", :disposition =>  'inline'

        end

      end
    end
  end
end

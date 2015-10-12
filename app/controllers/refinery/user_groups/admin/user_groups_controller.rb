# encoding: utf-8
module Refinery
  module UserGroups
    module Admin
      class UserGroupsController < ::Refinery::AdminController

        def create_items

          if params[:member_ids].present? && params[:group_id].present?

#            user_group.find(params[:group_id]).items.destroy_all

            params[:member_ids].each do |member_id|
              item.find_or_create_by_refinery_member_id_and_refinery_user_group_id(member_id, params[:group_id])
            end
            redirect_to  item_path(params[:group_id]) , :success => '已经成功将用户加入小组.'
          else
            redirect_to refinery.members_admin_members_path, :alert => '请选择用户或者小组.'
          end

        end

        def item
          Refinery::UserGroups::Item
        end

        def user_group
          Refinery::UserGroups::UserGroup
        end

        def item_path(group_id)
          "/refinery/user_groups/#{group_id}/items"
        end

        helper_method :item_path
        protected :item, :item_path, :user_group

        crudify :'refinery/user_groups/user_group',
          :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end

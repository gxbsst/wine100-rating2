#encoding: utf-8
module Refinery
  module WineGroups
    module Admin
      class WineGroupsController < ::Refinery::AdminController

        def create_wine_group_items
          if params[:wine_ids].present? && params[:group_id].present?
            params[:wine_ids].each {|wine_id| Refinery::WineGroups::WineGroupItem.create(:group_id => params[:group_id], :wine_id => wine_id)}
            redirect_to  "/refinery/wine_groups/#{params[:group_id]}/wine_group_items", :success => '已经成功将酒加入小组.'
          else
            redirect_to refinery.wines_admin_wines_path, :alert => '请选择酒或者小组.'
          end
        end

        crudify :'refinery/wine_groups/wine_group',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end

#encoding: utf-8
module Refinery
  module WineGroups
    module Admin
      class WineGroupsController < ::Refinery::AdminController

        def create_wine_group_items
          if params[:wine_ids].present? && params[:group_id].present?

           # wine_group.find(params[:group_id]).wine_group_items.destroy_all

            params[:wine_ids].each do  |wine_id| 
              item.find_or_create_by_wine_id_and_group_id(wine_id, params[:group_id])
            end
            redirect_to  item_path(params[:group_id]), :success => '已经成功将酒加入小组.'
          else
            redirect_to refinery.wines_admin_wines_path, :alert => '请选择酒或者小组.'
          end
        end

        def item
          Refinery::WineGroups::WineGroupItem
        end

        def wine_group
          Refinery::WineGroups::WineGroup
        end

        def item_path(group_id)
          "/refinery/wine_groups/#{group_id}/wine_group_items"
        end

        protected :item, :item_path, :wine_group

        crudify :'refinery/wine_groups/wine_group',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end

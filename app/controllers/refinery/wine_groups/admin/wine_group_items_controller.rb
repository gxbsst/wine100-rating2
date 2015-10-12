#encoding: utf-8
module Refinery
  module WineGroups
    module Admin
      class WineGroupItemsController < ::Refinery::AdminController

        #crudify :'refinery/wine_groups/wine_group_item', :xhr_paging => true
        #prepend_before_filter :find_wine_group_items, :only => [:update, :destroy, :edit, :show]
        before_filter :get_wine_group

        def index
          page = params[:page] || 1
          if @wine_group
            @wine_group_items = @wine_group.wine_group_items.order(:position).paginate(:page => page, :per_page => 20)
          else
            @wine_group = WineGroup.first
            @wine_group_items = WineGroupItem.order(:position).paginate(:page => page, :per_page => 20)
          end
        end

        def destroy
          item =  Refinery::WineGroups::WineGroupItem.find(params[:id])
          if item.destroy
            flash.notice = t('destroyed', :scope => 'refinery.crudify')
            redirect_to item_path(item.group_id)
          end
        end

        def get_wine_group
          if params[:wine_group_id]
            @wine_group = Refinery::WineGroups::WineGroup.find(params[:wine_group_id])
          else
            @wine_group = Refinery::WineGroups::WineGroup.first
          end
        end

        def item_path(group_id)
          "/refinery/wine_groups/#{group_id}/wine_group_items"
        end

        protected :get_wine_group

        class << self
          def pageable?
            false
          end
          alias_method :paging?, :pageable?

          def sortable?
            false
          end

          def searchable?
            false
          end
        end

      end
    end
  end
end


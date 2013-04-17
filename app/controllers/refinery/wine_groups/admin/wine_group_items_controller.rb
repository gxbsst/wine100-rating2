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
          @wine_group_items = @wine_group.wine_group_items.order(:position).paginate(:page => page, :per_page => 20)
        end

        def destroy
          if Refinery::WineGroups::WineGroupItem.destroy(params[:id])
            flash.notice = t('destroyed', :scope => 'refinery.crudify')
            redirect_to refinery.wine_groups_admin_wine_group_wine_group_items_path(@wine_group)
          end
        end

        def get_wine_group
          @wine_group = Refinery::WineGroups::WineGroup.find(params[:wine_group_id])
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


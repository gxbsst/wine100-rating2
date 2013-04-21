module Refinery
  module UserGroups
    module Admin
      class ItemsController < ::Refinery::AdminController

        # crudify :'refinery/user_groups/item', :xhr_paging => true
        before_filter :get_user_group

        def index
          page = params[:page] || 1
          if @user_group
            @items = @user_group.items.order(:position).
              paginate(:page => page, :per_page => 1000)
          else
            @user_group = UserGroup.first
            @items = Item.order(:position).paginate(:page => page, :per_page => 1000)
          end
        end

        def destroy
          item =  Refinery::UserGroups::Item.find(params[:id])
          if item.destroy
            flash.notice = t('destroyed', :scope => 'refinery.crudify')
            redirect_to item_path(item.refinery_user_group_id)
          end
        end

        def get_user_group
          @user_group = user_group.find(params[:user_group_id]) if params[:user_group_id]
        end

        def user_group
          Refinery::UserGroups::UserGroup
        end

        def item_path(group_id)
          "/refinery/user_groups/#{group_id}/items"
        end

        protected :get_user_group, :user_group



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

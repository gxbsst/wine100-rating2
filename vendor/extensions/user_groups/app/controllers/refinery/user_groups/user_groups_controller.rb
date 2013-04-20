module Refinery
  module UserGroups
    class UserGroupsController < ::ApplicationController

      before_filter :find_all_user_groups
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @user_group in the line below:
        present(@page)
      end

      def show
        @user_group = UserGroup.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @user_group in the line below:
        present(@page)
      end

    protected

      def find_all_user_groups
        @user_groups = UserGroup.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/user_groups").first
      end

    end
  end
end

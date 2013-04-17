module Refinery
  module WineGroups
    class WineGroupItemsController < ::ApplicationController

      before_filter :find_all_wine_group_items
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine_group_item in the line below:
        present(@page)
      end

      def show
        @wine_group_item = WineGroupItem.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine_group_item in the line below:
        present(@page)
      end

    protected

      def find_all_wine_group_items
        @wine_group_items = WineGroupItem.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/wine_group_items").first
      end

    end
  end
end

module Refinery
  module UserGroups
    class ItemsBbbbController < ::ApplicationController

      before_filter :find_all_items
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @item in the line below:
        present(@page)
      end

      def show
        @item = Item.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @item in the line below:
        present(@page)
      end

    protected

      def find_all_items
        @items = Item.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/items").first
      end

    end
  end
end

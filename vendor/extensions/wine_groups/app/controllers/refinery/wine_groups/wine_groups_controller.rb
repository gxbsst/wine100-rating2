module Refinery
  module WineGroups
    class WineGroupsController < ::ApplicationController

      before_filter :find_all_wine_groups
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine_group in the line below:
        present(@page)
      end

      def show
        @wine_group = WineGroup.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine_group in the line below:
        present(@page)
      end

    protected

      def find_all_wine_groups
        @wine_groups = WineGroup.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/wine_groups").first
      end

    end
  end
end

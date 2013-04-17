module Refinery
  module Wines
    class WinesController < ::ApplicationController

      before_filter :find_all_wines
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine in the line below:
        present(@page)
      end

      def show
        @wine = Wine.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @wine in the line below:
        present(@page)
      end

    protected

      def find_all_wines
        @wines = Wine.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/wines").first
      end

    end
  end
end

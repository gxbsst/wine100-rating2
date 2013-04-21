module Refinery
  module TestPapers
    class TestPapersController < ::ApplicationController

      before_filter :find_all_test_papers
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @test_paper in the line below:
        present(@page)
      end

      def show
        @test_paper = TestPaper.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @test_paper in the line below:
        present(@page)
      end

    protected

      def find_all_test_papers
        @test_papers = TestPaper.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/test_papers").first
      end

    end
  end
end

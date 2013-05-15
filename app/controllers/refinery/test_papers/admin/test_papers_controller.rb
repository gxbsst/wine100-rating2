module Refinery
  module TestPapers
    module Admin
      class TestPapersController < ::Refinery::AdminController

        crudify :'refinery/test_papers/test_paper',
                :title_attribute => 'score', :xhr_paging => true

        EXCEL_TITLES = ['code', 'wine', 'user', 'score', 'begin_at', 'end_at', 'note']

        def index
          page = params[:page] || 1
          per_page = 1000

          # For One Wine Group
          if params[:wine_group_id].present?
            @wine_group = wine_group(params[:wine_group_id])
            @test_papers = wine_group_notes(@wine_group.id).paginate(:page => page, :per_page => per_page)
          end

          # For One Wine
          if params[:wine_id].present?
            @wine = Refinery::Wines::Wine.find(params[:wine_id])
            @test_papers = Refinery::TestPapers::TestPaper.fetch(@wine.id).paginate(:page => page, :per_page => per_page)
          end

          # For User Group
          if params[:group_id].present?
            @group = Refinery::UserGroups::UserGroup.find(params[:group_id])
            @test_papers = Refinery::TestPapers::TestPaper.fetch_for_group(@group.id).paginate(:page => page, :per_page => per_page)
          end

        end

        def export
          @wine = Refinery::Wines::Wine.find(params[:wine_id])
          @test_papers = Refinery::TestPapers::TestPaper.fetch(@wine.id)
          @titles = EXCEL_TITLES
          render  :xlsx => 'export',:filename =>  "#{@wine.name_en}_#{@wine.vingate}", :disposition =>  'inline'
        end

        def export_for_group
          @group = Refinery::UserGroups::UserGroup.find(params[:group_id])
          @test_papers = Refinery::TestPapers::TestPaper.fetch_for_group(@group.id)
          @titles = EXCEL_TITLES
          render  :xlsx => 'export_for_group',:filename =>  "group_#{@group.name}", :disposition =>  'inline'
        end

        def export_for_wine_group

          @wine_group = wine_group(params[:wine_group_id])
          @test_papers = wine_group_notes(@wine_group.id)

          @titles = EXCEL_TITLES
          render  :xlsx => 'export_for_wine_group',:filename =>  "#{@wine_group.name}", :disposition =>  'inline'
        end

        def export_all
          @titles = EXCEL_TITLES
          @test_papers = Refinery::TestPapers::TestPaper.order('position DESC')
          render  :xlsx => 'export_all',:filename =>  "all_wines_notes", :disposition =>  'inline'
        end

        protected

        def wine_group_notes(wine_group_id)
          Refinery::TestPapers::TestPaper.fetch_for_wine_group(wine_group_id)
        end

        def wine_group(wine_group_id)
          Refinery::WineGroups::WineGroup.find(wine_group_id)
        end

      end
    end
  end
end

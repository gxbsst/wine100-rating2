module Refinery
  module TestPapers
    module Admin
      class TestPapersController < ::Refinery::AdminController

        crudify :'refinery/test_papers/test_paper',
                :title_attribute => 'score', :xhr_paging => true

        def export
          @wine = Refinery::Wines::Wine.find(params[:wine_id])
          @test_papers = Refinery::TestPapers::TestPaper.fetch(@wine.id)
          @titles = ['wine', 'user', 'score', 'begin_at', 'end_at', 'note']
          render  :xlsx => 'export',:filename =>  "wine_#{@wine.id}", :disposition =>  'inline'
        end

        def export_for_group
          @group = Refinery::UserGroups::UserGroup.find(params[:group_id])
          @test_papers = Refinery::TestPapers::TestPaper.fetch_for_group(@group.id)
          @titles = ['wine', 'user', 'score', 'begin_at', 'end_at', 'note']
          render  :xlsx => 'export_for_group',:filename =>  "group_#{@group.name}", :disposition =>  'inline'
        end

      end
    end
  end
end

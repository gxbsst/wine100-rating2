module Refinery
  module TestPapers
    module Admin
      class TestPapersController < ::Refinery::AdminController

        crudify :'refinery/test_papers/test_paper',
                :title_attribute => 'score', :xhr_paging => true

      end
    end
  end
end

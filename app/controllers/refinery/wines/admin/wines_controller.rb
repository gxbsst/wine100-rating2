module Refinery
  module Wines
    module Admin
      class WinesController < ::Refinery::AdminController


        crudify :'refinery/wines/wine',
                :title_attribute => 'name_zh', :xhr_paging => true
        def index
          if params[:search]
            q = "%#{params[:search]}%"
            @wines = Refinery::Wines::Wine.order(:created_a => 'DESC').where(["name_zh LIKE ? OR name_en Like ? ", q, q]).page(1).per_page(10000)
          else
            @wines = Refinery::Wines::Wine.order(:created_a => 'DESC').page(1).per_page(10000)
          end
        end

        def export_wine_notes
          @wines = Refinery::Wines::Wine.where(:id => params[:wine_ids])
          render  :xlsx => 'export_wine_notes',:filename =>  "wine_note", :disposition =>  'inline'
        end

      end
    end
  end
end

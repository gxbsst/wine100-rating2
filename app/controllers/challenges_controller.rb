class ChallengesController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :authenticate_user

  def index
    wine_groups

  end

  def show
    wine_groups
    wine_group
  end

  def create
    t = params[:test_paper]

    @tp =  Refinery::TestPapers::TestPaper.
        find_or_initialize_by_user_id_and_wine_id_and_group_id(@user.id, t[:wine_id], t[:group_id])
    @tp.score = t[:score]
    @tp.drink_begin_at = t[:drink_begin_at]
    @tp.drink_end_at = t[:drink_end_at]
    @tp.note = t[:note]

    if @tp.save
      respond_with(@tp) do |format|
        format.json { render }
      end
    end
  end

  def wine_group
    @wine_group = Refinery::WineGroups::WineGroup.find(params[:id])
  end

  def wine_groups
    @wine_groups = Refinery::WineGroups::WineGroup.all
  end

  def get_user
    @user ||= current_user
  end
end

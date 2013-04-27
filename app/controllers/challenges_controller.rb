class ChallengesController < ApplicationController
  respond_to :html, :xml, :js
  before_filter :authenticate_user

  def index
    wine_group
    redirect_to  challenge_path(wine_group)
    #wine_groups
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

    if @tp.valid?
      @tp.save
      #respond_to do |format|
      #  format.json { render :json => @tp }
      #end
      respond_with(@tp) do |format|
        format.js { render :tp => @tp }
      end
    end
  end

  def update

    t = params[:test_paper]
    @tp =  Refinery::TestPapers::TestPaper.find(params[:id])
    @tp.score = t[:score]
    @tp.drink_begin_at = t[:drink_begin_at]
    @tp.drink_end_at = t[:drink_end_at]
    @tp.note = t[:note]

    #binding.pry
    if @tp.valid?
      @tp.save
      respond_with(@tp)
      #respond_to do |format|
      #  format.html
      #  format.any(:js) { render :tp => @tp }
      #end
    end
  end

  def wine_group
    #id = params[:id] || 1
    @wine_group = Refinery::WineGroups::WineGroup.first
  end

  def wine_groups
    @wine_groups = Refinery::WineGroups::WineGroup.order(:position)
  end

  def get_user
    @user ||= current_user
  end
end

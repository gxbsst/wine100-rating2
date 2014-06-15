class WineGroupsController < ApplicationController
  respond_to :html, :xml, :js
  before_filter :authenticate_user

  def index
    @complete_count = Refinery::WineGroups::WineGroup.complete.count
    respond_to do |format|
      format.html
      format.json { render :json => {:complete_count => @complete_count}}
    end
  end

  def progress
    # redirect_to root_path  unless current_user.leader?
    @wine_groups = Refinery::WineGroups::WineGroup.all
    @wine_groups_count = @wine_groups.count
    @complete_count = Refinery::WineGroups::WineGroup.complete.count
    @percent = (@complete_count.to_f / @wine_groups_count.to_f) * 100
    respond_to  do |format|
      format.html
      format.json { render :json => {:percent => @percent} }
    end
  end

  def complete
    set_wine_group
    if @wine_group.update_attribute(:state, 'complete')
      redirect_to "/challenges/#{@wine_group.id}"
    end
  end

  def cancel
    set_wine_group
    if @wine_group.update_attribute(:state, 'cancel')
      redirect_to "/challenges/#{@wine_group.id}"
    end
  end

  private

  def set_wine_group
    @wine_group ||= Refinery::WineGroups::WineGroup.find(params[:id])
  end
end
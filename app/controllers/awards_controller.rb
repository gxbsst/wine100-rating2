class AwardsController < ApplicationController
  respond_to :html, :xml, :js
  before_filter :authenticate_user

  def create
    award = Award.find_or_initialize_by_wine_id_and_refinery_member_id(params['wine_id'], current_user.id)
    award.award = params['award']
    award.wine_id = params['wine_id']
    if award.save!
      render :json => award, :status => :ok
    else
      render :json => award, :status => :unprocessable_entity
    end
  end

end

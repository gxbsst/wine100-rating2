class User < ::Refinery::Members::Member
  has_many :awards, :class_name => 'Award', :foreign_key => 'refinery_member_id'
  def leader?
    self.role == 'leader'
  end
  def e_group?
    self.role == 'e_group'
  end

  def group
    item = Refinery::UserGroups::Item.find_by_refinery_member_id(self.id)
    return nil unless item.present?
    Refinery::UserGroups::UserGroup.find(item.refinery_user_group_id)
  end
end
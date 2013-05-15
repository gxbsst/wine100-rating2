# encoding: utf-8
module ApplicationHelper

  #def wine_group_wine_group_items_path(wine_group)
  #  "/refinery/wine_groups/#{wine_group.id}/wine_group_items"
  #end
  #
  #def post_wine_to_item_path
  #  "/refinery/wine_groups/wine_group_items"
  #end

  def wine_check_box(wine, group_id)
    if group_id.present?
      group = Refinery::WineGroups::WineGroup.find(group_id)
      wine_ids = group.wine_group_items.collect(&:wine_id)
      #check_box_tag 'wine_ids[]', wine.id, (wine_ids.include? wine.id) ? true : false
      check_box_tag 'wine_ids[]', wine.id, false
    else
      check_box_tag 'wine_ids[]', wine.id, false
    end
  end

  def user_check_box(member, group_id)
    if group_id.present?
      group = Refinery::UserGroups::UserGroup.find(group_id)
      member_ids = group.items.collect(&:refinery_member_id)
      #check_box_tag 'member_ids[]', member.id, (member_ids.include? member.id) ? true : false
      check_box_tag 'member_ids[]', member.id, false
    else
      check_box_tag 'member_ids[]', member.id, false
    end
  end

  def select_wine_group(group_id)
    select_tag(:group_id,
               options_from_collection_for_select(wine_group_all, "id", "name",:selected => group_id ? group_id : nil),
               :prompt => "请选择要加入的酒组")

  end

  def select_user_group(group_id)
    select_tag(:group_id, 
               options_from_collection_for_select(user_group_all, "id", "name",:selected => group_id ? group_id : nil),
               :prompt => "请选择要加入的用户组")

  end

  def wine_group_all
    Refinery::WineGroups::WineGroup.all
  end

  def user_group_all
    Refinery::UserGroups::UserGroup.all
  end

  def c_path(test_paper)
    if test_paper.new_record?
      challenges_path
    else
      challenge_path(test_paper)
    end
  end

  def export_path(wine_id)
  "/refinery/test_papers/#{wine_id}/export"
  end

  def export_group_path(group_id)
  "/refinery/test_papers/#{group_id}/export_for_group"
  end

  def export_wine_group_path(wine_group_id)
    "/refinery/test_papers/#{wine_group_id}/export_for_wine_group"
  end

  def export_all_path
    "/refinery/test_papers/export_all"
  end

end

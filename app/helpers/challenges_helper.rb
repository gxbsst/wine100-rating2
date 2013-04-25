#encoding: utf-8
module ChallengesHelper
  def show_edit_status(test_paper)
    unless test_paper.new_record?
      content_tag :span, :class => 'label label-info' do
      "已写"
      end
    end
  end
end

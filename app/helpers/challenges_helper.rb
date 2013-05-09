#encoding: utf-8
module ChallengesHelper
  def show_edit_status(test_paper)
    unless test_paper.new_record?
      content_tag :sup, :class => 'label label-success' do
       content_tag :i,test_paper.score, :class => 'icon-ok'
      end
    else
      content_tag :sup, :class => 'label label-important' do
        content_tag :i,'', :class => 'icon-remove'
      end
    end
  end

  def edit_note_button(test_paper)
    if test_paper.new_record?
      link_to 'javascript:void(0)', :class => 'open_toggle new_record' do
        content_tag :i, ' New Note', :class => 'icon-file'
      end
    else
      link_to 'javascript:void(0)', :class => :open_toggle do
        content_tag :i, ' Edit Note', :class => 'icon-edit'
      end
    end
  end

end

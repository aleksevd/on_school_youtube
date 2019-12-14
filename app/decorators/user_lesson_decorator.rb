class UserLessonDecorator < ApplicationDecorator
  delegate_all

  def state_class
    @state_class ||= case state
                     when 'completed'
                       'success'
                     when 'active'
                       'info'
                     when 'checking'
                       'warning'
                     when 'rejected'
                       'danger'
                     end
  end

  def icon_class
    @icon_class ||= case state
                    when 'completed'
                      'glyphicon-ok'
                    when 'checking'
                      'glyphicon-pencil'
                    when 'rejected'
                      'glyphicon-retweet'
                    else
                      ''
                    end
  end
end

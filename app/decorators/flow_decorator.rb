class FlowDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{l(flow.starts_at.to_date)} - #{l(flow.finishes_at.to_date)}"
  end

  def state_class
    @state_class ||= case state
                     when 'in_future'
                       'info'
                     when 'active'
                       'success'
                     when 'checks_finished'
                       'warning'
                     when 'finished'
                       'default'
                     end
  end
end

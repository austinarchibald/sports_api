require 'time'

class SportsApi::Model::Status
  attr_accessor :display_clock,
                :period,
                :state,
                :detail,
                :start_time

  def start_time
    pregame? ? Time.parse(detail) : nil
  end

  def period=(period)
    @period = period.to_s
  end

  def inprogress?
    state == 'in'
  end

  def final?
    state == 'post'
  end

  def pregame?
    state == 'pre'
  end
end

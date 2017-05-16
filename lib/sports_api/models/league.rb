class SportsApi::Model::League
  CALENDAR_TYPES = [
    DAY = 'day',
    LIST = 'list'
  ]

  attr_accessor :name,
                :abbreviation,
                :start_date,
                :end_date,
                :calendar_type,
                :calendar,
                :events

  def calendar=(events)
    @calendar ||= events
  end
end

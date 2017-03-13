require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NCB < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  def league
    SportsApi::NCB
  end

  private

  def generate_calendar(calendar_json)
    generate_calendar_day(calendar_json)
  end

  def json
    @json ||= get('basketball', 'mens-college-basketball', dates: date.to_s.gsub(/[^\d]+/, '').to_i, limit: 200, groups: 100)
    # Note: Behavior of NCB api slightly different than other sports. It returns null for any date < Nov 1 2016
  end
end

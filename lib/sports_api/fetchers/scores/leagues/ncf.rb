require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NCF < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  def response
    generate_league
  end

  def league
    SportsApi::NCF
  end

  private

  def generate_calendar(calendar_json)
    generate_calendar_list(calendar_json)
  end

  def json
    @json ||= get('football', 'college-football', dates: date.to_s.gsub(/[^\d]+/, '').to_i, limit: 300, groups: 80)
  end
end

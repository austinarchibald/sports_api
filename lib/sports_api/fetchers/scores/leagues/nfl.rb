require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NFL < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  attr_accessor :season_type

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  def league
    SportsApi::NFL
  end

  private

  def generate_calendar(calendar_json)
    generate_calendar_list(calendar_json)
  end

  def json
    @json ||= get('football', 'nfl', dates: date.to_s.gsub(/[^\d]+/, '').to_i)
  end
end
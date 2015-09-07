require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NFL < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  attr_accessor :season_type

  def initialize(season_type, week)
    self.week = week
    self.season_type = season_type
  end

  def self.find(date)
    date_obj = date_list(date)

    SportsApi::Fetcher::Score::NFL.find_by(date_obj.season, date_obj.week)
  end

  def self.find_by(season_type, week)
    new(season_type, week).response
  end

  private

  def self.date_list(date)
    SportsApi::Fetcher::Calendar::NFL.find.detect do |list|
      (list.start_date < date) && (date < list.end_date)
    end
  end

  def generate_calendar(calendar_json)
    generate_calendar_list(calendar_json)
  end

  def json
    @json ||= get('football', 'nfl', week: week, seasontype: season_type)
  end

  def league
    SportsApi::NFL
  end
end

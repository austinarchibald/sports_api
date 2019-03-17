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
    @json ||= get('basketball', 'mens-college-basketball', dates: date.to_s.gsub(/[^\d]+/, '').to_i, limit: 300, groups: 100)
    # change groups to 100 for Tourney Time, 50 for regular
    # Note: Behavior of NCB api slightly different than other sports. It returns null for any date < Nov 1 2016
  end
end

# CBI
# http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?lang=en&region=us&calendartype=blacklist&limit=300&dates=20170314&tz=America%2FNew_York&groups=55

# CIT
# http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?lang=en&region=us&calendartype=blacklist&limit=300&dates=20170314&tz=America%2FNew_York&groups=56

# NIT
# http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?lang=en&region=us&calendartype=blacklist&limit=300&dates=20170314&tz=America%2FNew_York&groups=50

# NCAA
# http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?lang=en&region=us&calendartype=blacklist&limit=300&dates=20170314&tz=America%2FNew_York&groups=100

class SportsApi::Fetcher::Calendar::NFL < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NFL.find(Date.today).calendar
  end
end

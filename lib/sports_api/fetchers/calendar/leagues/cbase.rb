class SportsApi::Fetcher::Calendar::CBASE < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::CBASE.find(Date.today).calendar
  end
end

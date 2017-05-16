class SportsApi::Fetcher::Calendar
  def self.find(league)
    case league
    when SportsApi::NCF
      SportsApi::Fetcher::Calendar::NCF.find
    when SportsApi::NFL
      SportsApi::Fetcher::Calendar::NFL.find
    when SportsApi::NBA
      SportsApi::Fetcher::Calendar::NBA.find
    when SportsApi::NCB
      SportsApi::Fetcher::Calendar::NCB.find
    when SportsApi::MLB
      SportsApi::Fetcher::Calendar::MLB.find
    when SportsApi::CBASE
      SportsApi::Fetcher::Calendar::CBASE.find
    end
  end
end

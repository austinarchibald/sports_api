class SportsApi::Model::Record
  attr_accessor :name,
                :summary

  def name
    @name ||= 'Total'
  end

  def summary
    @summary
  end
end

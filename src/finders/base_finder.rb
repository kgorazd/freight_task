# frozen_string_literal: true

class BaseFinder
  PORTS = %w[CNSHA NLRTM BRSSZ ESBCN].freeze

  private

  def data
    @data ||= DataSource.instance
  end

  def validate_sailing_property!(property)
    raise "invalid property #{property}" unless %i[cost_in_euro duration].include?(property)
    raise "invalid property #{property}" unless Sailing.new({}).respond_to?(property)
  end
end

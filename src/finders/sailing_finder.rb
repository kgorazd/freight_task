# frozen_string_literal: true

class SailingFinder < BaseFinder
  def cheapest_direct_sailing(from, to, earliest_departure_date = nil)
    best_direct_sailing(from, to, :cost_in_euro, earliest_departure_date)
  end

  def fastets_direct_sailing(from, to, earliest_departure_date = nil)
    best_direct_sailing(from, to, :duration, earliest_departure_date)
  end

  def best_direct_sailing(from, to, property, earliest_departure_date = nil)
    validate_sailing_property!(property)

    best_sailing(direct_sailings(from, to, earliest_departure_date), property)
  end

  def cheapest_sailing(sailings_data)
    best_sailing(sailings_data, :cost_in_euro)
  end

  def fastest_sailing(sailings_data)
    best_sailing(sailings_data, :duration)
  end

  def best_sailing(sailings_data, property)
    validate_sailing_property!(property)

    sailings_data.map { |sd| Sailing.new(sd) }
                 .min_by(&property)
  end

  def direct_sailings(from, to, earliest_departure_date = nil)
    if earliest_departure_date && !DateHelper.valid?(earliest_departure_date)
      raise 'invalid earliest_departure_date value'
    end

    scope = data.sailings
    if earliest_departure_date
      scope = scope.select do |s|
        DateHelper.greater?(s['departure_date'], earliest_departure_date)
      end
    end
    scope.select do |sailing_data|
      sailing_data['origin_port'] == from && sailing_data['destination_port'] == to
    end
  end
end

# frozen_string_literal: true

class RouteFinder < BaseFinder
  def cheapest_route(from, to)
    best_by_propery_route(from, to, :cost_in_euro)
  end

  def fastest_route(from, to)
    best_by_propery_route(from, to, :duration)
  end

  def best_by_propery_route(from, to, property)
    validate_sailing_property!(property)

    sample_sailing = sailing_finder.best_direct_sailing(from, to, property)
    return [] unless sample_sailing

    result_candidate = {
      legs: [sample_sailing],
      score: sample_sailing.send(property)
    }

    stops_permutations = all_stops_permutations(from, to)
    stops_permutations.each do |stops|
      legs = best_route_by_stops(from, stops, property)
      next if legs.empty?

      total_score = legs.sum(&property)
      next unless total_score && total_score < result_candidate[:score]

      result_candidate = {
        legs: legs,
        score: total_score
      }
    end

    result_candidate[:legs]
  end

  def cheapest_route_by_stops(from, stops, _earliest_departure_date = nil)
    best_route_by_stops(from, stops, :cost_in_euro, nil)
  end

  def fastest_route_by_stops(from, stops, _earliest_departure_date = nil)
    best_route_by_stops(from, stops, :duration, nil)
  end

  def best_route_by_stops(from, stops, property, earliest_departure_date = nil)
    validate_sailing_property!(property)

    if stops.size == 1
      [sailing_finder.best_direct_sailing(from, stops[0], property, earliest_departure_date)]
    else
      first_leg = sailing_finder.best_direct_sailing(from, stops[0], property)

      return [] unless first_leg

      other_legs = best_route_by_stops(stops[0], stops[1..], property, first_leg.sailing_data['arrival_date']).compact
      return [] unless other_legs.any?

      [first_leg] + other_legs
    end
  end

  private

  def all_stops_permutations(from, to)
    stopovers = %w[CNSHA NLRTM BRSSZ ESBCN] - [from, to]
    stops_permutations = all_permutations(stopovers)
    stops_permutations.each { |stops| stops << to }
  end

  def all_permutations(arr = %w[B C])
    (1..arr.length).inject(Enumerator::Chain.new) { |acc, i| acc + arr.permutation(i) }.to_a
  end

  def sailing_finder
    SailingFinder.new
  end
end

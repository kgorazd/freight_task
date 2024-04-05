# frozen_string_literal: true

require 'json'
require 'bigdecimal'
require 'singleton'
require 'pry'
require 'date'
require 'httparty'

Dir['./src/**/*.rb'].sort.each { |file| require file }

class SolutionService
  # PLS-0001
  def self.cheapest_direct_sailing(from, to)
    SailingFinder.new.cheapest_direct_sailing(from, to)&.format
  end

  # WRT-0002
  def self.cheapest_sailing(from, to)
    RouteFinder.new.cheapest_route(from, to).map(&:format)
  end

  # TST-0003
  def self.fastest_sailing(from, to)
    RouteFinder.new.fastest_route(from, to).map(&:format)
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe RouteFinder do
  let(:data) { DataSource.instance }
  let(:finder) { RouteFinder.new }

  describe '#cheapest_route' do
    it 'returns cheapest route if such route exists' do
      result = finder.cheapest_route('CNSHA', 'NLRTM')
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
        { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-15',
          'arrival_date' => '2022-03-29', 'sailing_code' => 'ETRF', 'rate' => '2.00', 'rate_currency' => 'USD' }
      ]

      expect(result.map(&:format)).to eq(expected_result)
    end

    it 'returns empty route if such route does not exists' do
      result = finder.cheapest_route('CNSHA', 'BRSSZ')
      expected_result = []

      expect(result.map(&:format)).to eq(expected_result)
    end
  end

  describe '#cheapest_route_by_stops' do
    it 'returns cheapest route if such route exists' do
      result = finder.cheapest_route_by_stops('CNSHA', %w[ESBCN NLRTM])
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
        { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-15',
          'arrival_date' => '2022-03-29', 'sailing_code' => 'ETRF', 'rate' => '2.00', 'rate_currency' => 'USD' }
      ]

      expect(result.map(&:format)).to eq(expected_result)
    end

    it 'returns empty route if such route does not exists' do
      result = finder.cheapest_route_by_stops('CNSHA', %w[NLRTM ESBCN])
      expected_result = []

      expect(result).to eq(expected_result)
    end
  end

  describe '#fastest_route' do
    it 'returns fastest route if such route exists' do
      result = finder.fastest_route('CNSHA', 'NLRTM')
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-15', 'sailing_code' => 'QRST', 'rate' => '761.96', 'rate_currency' => 'EUR' }
      ]
      expect(result.map(&:format)).to eq(expected_result)
    end

    it 'returns empty route if such route does not exists' do
      result = finder.fastest_route('CNSHA', 'BRSSZ')
      expected_result = []

      expect(result.map(&:format)).to eq(expected_result)
    end
  end

  describe '#fastest_route_by_stops' do
    it 'returns fastest route if such route exists' do
      result = finder.fastest_route_by_stops('CNSHA', %w[ESBCN NLRTM])
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
        { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-16',
          'arrival_date' => '2022-02-20', 'sailing_code' => 'ETRG', 'rate' => '69.96', 'rate_currency' => 'USD' }
      ]

      expect(result.map(&:format)).to eq(expected_result)
    end

    it 'returns empty route if such route does not exists' do
      result = finder.fastest_route_by_stops('CNSHA', %w[NLRTM ESBCN])
      expected_result = []

      expect(result).to eq(expected_result)
    end
  end
end

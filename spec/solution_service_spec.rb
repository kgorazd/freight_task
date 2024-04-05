# frozen_string_literal: true

require 'spec_helper'

describe SolutionService do
  let(:data) { DataSource.instance }
  let(:sailing) { Sailing.new(data.sailings.first) }

  describe 'PLS-0001' do
    it 'calls #cheapest_direct_sailing' do
      result = SolutionService.cheapest_direct_sailing('CNSHA', 'NLRTM')
      expected_result = { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-30',
                          'arrival_date' => '2022-03-05', 'sailing_code' => 'MNOP', 'rate' => '456.78', 'rate_currency' => 'USD' }

      expect(result).to eq(expected_result)
    end
  end

  describe 'WRT-0002' do
    it 'calls #cheapest_sailing' do
      result = SolutionService.cheapest_sailing('CNSHA', 'NLRTM')
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
        { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-15',
          'arrival_date' => '2022-03-29', 'sailing_code' => 'ETRF', 'rate' => '2.00', 'rate_currency' => 'USD' }
      ]

      expect(result).to eq(expected_result)
    end
  end

  describe 'TST-0003' do
    it 'calls #fastest_sailing' do
      result = SolutionService.fastest_sailing('CNSHA', 'NLRTM')
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
        { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-15',
          'arrival_date' => '2022-03-29', 'sailing_code' => 'ETRF', 'rate' => '2.00', 'rate_currency' => 'USD' }
      ]

      expect(result).to eq(expected_result)
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe SailingFinder do
  let(:data) { DataSource.instance }
  let(:finder) { SailingFinder.new }

  describe '#direct_sailings' do
    it 'returns all direct sailings if they exists' do
      result = finder.direct_sailings('CNSHA', 'NLRTM')
      expected_result = [
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-01',
          'arrival_date' => '2022-03-01', 'sailing_code' => 'ABCD' },
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-02',
          'arrival_date' => '2022-03-02', 'sailing_code' => 'EFGH' },
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-31',
          'arrival_date' => '2022-02-28', 'sailing_code' => 'IJKL' },
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-30',
          'arrival_date' => '2022-03-05', 'sailing_code' => 'MNOP' },
        { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-29',
          'arrival_date' => '2022-02-15', 'sailing_code' => 'QRST' }
      ]

      expect(result).to eq(expected_result)
    end

    it 'returns empty array when there are no direct sailings' do
      result = finder.direct_sailings('CNSHA', 'BRSSZ')
      expected_result = []

      expect(result).to eq(expected_result)
    end
  end

  describe '#cheapest_sailing' do
    it 'returns cheapest sailing if it exists' do
      result = finder.cheapest_sailing(data.sailings)
      expected_result = { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-01',
                          'arrival_date' => '2022-03-29', 'sailing_code' => 'ETRF2' }

      expect(result.sailing_data).to eq(expected_result)
      expect(result.cost_in_euro).to eq(0.89)
    end

    it 'returns nil if there are no proper sailings available' do
      result = finder.cheapest_sailing([])

      expect(result).to eq(nil)
    end
  end

  describe '#cheapest_direct_sailing' do
    it 'returs cheapest direct sailing if it exists' do
      result = finder.cheapest_direct_sailing('CNSHA', 'NLRTM')
      expected_result = { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-30',
                          'arrival_date' => '2022-03-05', 'sailing_code' => 'MNOP' }

      expect(result.sailing_data).to eq(expected_result)
    end

    it 'returns nil if there are no direct sailing available' do
      result = finder.cheapest_direct_sailing('CNSHA', 'BRSSZ')

      expect(result).to eq(nil)
    end
  end

  describe '#fastest_sailing' do
    it 'returns fastest sailing if it exists' do
      result = finder.fastest_sailing(data.sailings)
      expected_result = { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-16',
                          'arrival_date' => '2022-02-20', 'sailing_code' => 'ETRG' }

      expect(result.sailing_data).to eq(expected_result)
      expect(result.duration).to eq(4)
    end

    it 'returns nil if there are no proper sailings available' do
      result = finder.fastest_sailing([])

      expect(result).to eq(nil)
    end
  end

  describe '#fastets_direct_sailing' do
    it 'returs fastest direct sailing if it exists' do
      result = finder.fastets_direct_sailing('CNSHA', 'NLRTM')
      expected_result = { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-29',
                          'arrival_date' => '2022-02-15', 'sailing_code' => 'QRST' }

      expect(result.sailing_data).to eq(expected_result)
    end

    it 'returns nil if there are no proper sailing available' do
      result = finder.fastets_direct_sailing('CNSHA', 'BRSSZ')

      expect(result).to eq(nil)
    end
  end

  describe '#best_sailing' do
    it 'returns best(by selected property) sailing if it exists' do
      result = finder.best_sailing(data.sailings, :duration)
      expected_result = { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-16',
                          'arrival_date' => '2022-02-20', 'sailing_code' => 'ETRG' }

      expect(result.sailing_data).to eq(expected_result)
      expect(result.duration).to eq(4)
    end

    it 'returns nil if there are no proper sailings available' do
      result = finder.best_sailing([], :duration)

      expect(result).to eq(nil)
    end
  end

  describe '#best_direct_sailing' do
    it 'returs best(by selected property) direct sailing if it exists' do
      result = finder.best_direct_sailing('CNSHA', 'NLRTM', :duration)
      expected_result = { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-29',
                          'arrival_date' => '2022-02-15', 'sailing_code' => 'QRST' }

      expect(result.sailing_data).to eq(expected_result)
    end

    it 'returns nil if there are no proper sailings available' do
      result = finder.best_direct_sailing('CNSHA', 'BRSSZ', :duration)

      expect(result).to eq(nil)
    end
  end
end

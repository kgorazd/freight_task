# frozen_string_literal: true

require 'spec_helper'

describe Sailing do
  let(:data) { DataSource.instance }
  let(:sailing) { Sailing.new(data.sailings.first) }

  describe '#format' do
    it do
      result = sailing.format
      expected_result = { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-01',
                          'arrival_date' => '2022-03-01', 'sailing_code' => 'ABCD', 'rate' => '589.30', 'rate_currency' => 'USD' }

      expect(result).to eq(expected_result)
    end
  end

  describe '#rate' do
    it do
      result = sailing.rate
      expect(result).to eq({ 'rate' => '589.30', 'rate_currency' => 'USD' })
    end
  end

  describe '#exchange_rate' do
    it do
      result = sailing.exchange_rate
      expect(result).to eq({ 'jpy' => 130.15, 'usd' => 1.126 })
    end
  end

  describe '#cost_in_euro' do
    context 'USD' do
      it 'returns valid result' do
        result = sailing.cost_in_euro
        expect(result).to eq(523.36)
      end
    end

    context 'JPY' do
      let(:sailing) { Sailing.new(data.sailings[2]) }

      it 'returns valid result' do
        result = sailing.cost_in_euro
        expect(result).to eq(742.78)
      end
    end
  end
end

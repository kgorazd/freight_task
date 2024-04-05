# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Roda setup', server_required: true do
  let(:base_url) { 'http://localhost:3000/' }
  # HTTParty.get(base_url)
  it 'PLS-0001' do
    endpoint = 'api/cheapest_direct_sailing?from=CNSHA&to=NLRTM'
    result = HTTParty.get(base_url + endpoint)
    expected_result = {
      'origin_port' => 'CNSHA',
      'destination_port' => 'NLRTM',
      'departure_date' => '2022-01-30',
      'arrival_date' => '2022-03-05',
      'sailing_code' => 'MNOP',
      'rate' => '456.78',
      'rate_currency' => 'USD'
    }
    expect(result.body).to eq(expected_result.to_json)
  end

  it 'WRT-0002' do
    endpoint = 'api/cheapest_sailing?from=CNSHA&to=NLRTM'
    result = HTTParty.get(base_url + endpoint)
    expected_result = [
      {
        'origin_port' => 'CNSHA',
        'destination_port' => 'ESBCN',
        'departure_date' => '2022-01-29',
        'arrival_date' => '2022-02-12',
        'sailing_code' => 'ERXQ',
        'rate' => '261.96',
        'rate_currency' => 'EUR'
      },
      {
        'origin_port' => 'ESBCN',
        'destination_port' => 'NLRTM',
        'departure_date' => '2022-02-16',
        'arrival_date' => '2022-02-20',
        'sailing_code' => 'ETRG',
        'rate' => '69.96',
        'rate_currency' => 'USD'
      }
    ]
    expect(result.body).to eq(expected_result.to_json)
  end

  it 'TSS-0003' do
    endpoint = 'api/fastest_sailing?from=CNSHA&to=NLRTM'
    result = HTTParty.get(base_url + endpoint)
    expected_result = [
      {
        'origin_port' => 'CNSHA',
        'destination_port' => 'NLRTM',
        'departure_date' => '2022-01-29',
        'arrival_date' => '2022-02-15',
        'sailing_code' => 'QRST',
        'rate' => '761.96',
        'rate_currency' => 'EUR'
      }
    ]
    expect(result.body).to eq(expected_result.to_json)
  end
end

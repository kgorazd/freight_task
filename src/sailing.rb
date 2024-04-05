# frozen_string_literal: true

class Sailing
  attr_reader :sailing_data

  SAILING_PROPERTIES = %w[origin_port destination_port departure_date arrival_date sailing_code].freeze
  RATE_PROPERTIES = %w[rate rate_currency].freeze

  def initialize(sailing_data)
    @sailing_data = sailing_data
  end

  def format
    rate_data = rate.slice(*RATE_PROPERTIES)
    result = sailing_data.slice(*SAILING_PROPERTIES)
    result.merge(rate_data)
  end

  def cost_in_euro
    currency = rate['rate_currency'].downcase
    amount = BigDecimal(rate['rate'])
    return amount if currency == 'eur'

    (amount / exchange_rate[currency]).round(2)
  end

  def rate
    DataSource.instance.rates[sailing_data['sailing_code']]
  end

  def exchange_rate
    DataSource.instance.exchange_rates[sailing_data['departure_date']]
  end

  def duration
    DateHelper.duration(sailing_data['departure_date'], sailing_data['arrival_date'])
  end
end

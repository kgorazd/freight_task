# frozen_string_literal: true

class DataSource
  include Singleton

  FILEPATH = 'data/response.json'

  def all
    @all ||= JSON.parse(file_content)
  end

  def exchange_rates
    all['exchange_rates']
  end

  def rates
    @rates ||= rates_indexed_by_sailing_code
  end

  def sailings
    all['sailings']
  end

  def reload(filepath = FILEPATH)
    @filepath = filepath
    @all = nil
    @rates = nil
  end

  private

  def file_content
    @filepath ||= FILEPATH
    File.read(@filepath)
  end

  def rates_indexed_by_sailing_code
    all['rates'].each_with_object({}) do |rate, indexed_rates|
      indexed_rates[rate['sailing_code']] = rate.slice('rate', 'rate_currency')
    end
  end
end

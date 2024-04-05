# frozen_string_literal: true

module DateHelper
  def self.valid?(date)
    date.is_a?(String) &&
      date.length == 10 &&
      /\d{4}-\d{2}-\d{2}/.match?(date)
  end

  def self.greater?(greater_date, other_date)
    greater_date > other_date
    # this implementation depends on the current date format yyyy-mm-dd - using different format for example dd-mm-yyyy or yyyy-dd-mm will require revamp with parsing and actual date comparation
    # DateTime.parse(greater_date) > DateTime.parse(other_date) - you also can pass format here if needed
  end

  def self.duration(date, later_date)
    (DateTime.parse(later_date) - DateTime.parse(date)).to_i
  end
end

# frozen_string_literal: true

require_relative 'solution'

puts 'PLS-0001'
puts SolutionService.cheapest_direct_sailing('CNSHA', 'NLRTM')
puts 'WRT-0002'
puts SolutionService.cheapest_sailing('CNSHA', 'NLRTM')
puts 'TST-0003'
puts SolutionService.fastest_sailing('CNSHA', 'NLRTM')

binding.pry if ENV['REPL'] == '1'

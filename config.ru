# frozen_string_literal: true

require 'roda'
require_relative 'solution'

class App < Roda
  route do |r|
    # GET / request
    r.root do
      "<h1>Available routes:</h1><br/>
      <h2>
        <a href='http://localhost:3000/api/cheapest_direct_sailing?from=CNSHA&to=NLRTM' />/api/cheapest_direct_sailing?from=CNSHA&to=NLRTM</a><br/>
        <a href='http://localhost:3000/api/cheapest_sailing?from=CNSHA&to=NLRTM' />/api/cheapest_sailing?from=CNSHA&to=NLRTM</a><br/>
        <a href='http://localhost:3000/api/fastest_sailing?from=CNSHA&to=NLRTM' />/api/fastest_sailing?from=CNSHA&to=NLRTM</a>
      </h2>"
    end

    r.on 'api' do
      response['Content-Type'] = 'application/json'

      # PLS-0001
      # /cheapest_direct_sailing?from=barbaz&to=rtg
      # /cheapest_direct_sailing?from=CNSHA&to=NLRTM
      r.get 'cheapest_direct_sailing' do
        from, to = r.params.slice('from', 'to').values
        puts "From: #{from}, To: #{to}"
        SolutionService.cheapest_direct_sailing(from, to).to_json
      end

      # WRT-0002
      # /cheapest_sailing?from=barbaz&to=rtg
      # /cheapest_sailing?from=CNSHA&to=NLRTM
      r.get 'cheapest_sailing' do
        from, to = r.params.slice('from', 'to').values
        puts "From: #{from}, To: #{to}"
        SolutionService.cheapest_sailing(from, to).to_json
      end

      # TST-0003
      # /fastest_sailing?from=barbaz&to=rtg
      # /fastest_sailing?from=CNSHA&to=NLRTM
      r.get 'fastest_sailing' do
        from, to = r.params.slice('from', 'to').values
        puts "From: #{from}, To: #{to}"
        SolutionService.fastest_sailing(from, to).to_json
      end
    end
  end
end

run App.freeze.app

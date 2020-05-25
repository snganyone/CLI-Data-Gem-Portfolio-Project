require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
require 'rest-client'
require 'pry'

class GitApi
    #Github Jobs API
    @@url = 'https://jobs.github.com/positions.json'
    def api
        uri = URI.parse(@@url)
        response = Net::HTTP.get_response(uri)
        response.body
        puts JSON.parse(response.body)
    end

    def get_request
        rest = RestClient.get(@@url, headers={})
        data = JSON.parse(rest.body)
        puts data
    end
end

GitApi.new.get_request

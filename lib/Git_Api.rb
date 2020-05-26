require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
require 'excon'
require 'pry'

class GitApi
    #Github Jobs API
    @@url = 'https://jobs.github.com/positions.json'
    #Excon Connection
    @@connection = Excon.new(@@url)

    def get_request
        response = @@connection.get
        response.body
    end

    def get_response
        jobs = JSON.parse(self.get_request)

        jobs.collect do |job|
            job['title']
        end
    end

end

puts GitApi.new.get_response

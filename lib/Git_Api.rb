require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
require 'rest-client'
require 'pry'

class GitApi
    #Github Jobs API
    @@url = 'https://jobs.github.com/positions.json'

    def get_request
        rest = RestClient.get(@@url, headers={})
        rest.body
    end

    def jobs
        jobs = JSON.parse(self.get_request)

        jobs.collect do |job|
            puts jobs
        end
    end
end

GitApi.new.jobs

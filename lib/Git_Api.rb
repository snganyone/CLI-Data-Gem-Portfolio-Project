require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
require 'excon'
require 'pry'

require_relative './Job.rb'

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
    end

    def create_jobs
        self.get_response.map.with_index do |job, idx|
            title = job['title']
            type = job['type']
            url = job['url']
            description = job['description']
            location = job['location']
            id = idx + 1
            #Create Job instances
            jobs = Job.new(id, title, type, url, location, description)
        end
    end


    def job_info(location)
        query = Job.find_by_location(location)
        res = Excon.get("#{@@url}#{location}")
    end
end

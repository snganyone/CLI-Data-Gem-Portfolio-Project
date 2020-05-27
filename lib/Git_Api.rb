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

        jobs.map.with_index do |job, idx|
            #id = job['id']
            #title = job['title']
            #type = job['type']
            #description = job['description']
            #url = job['url']
            #location = job['location']
            #puts "#{job['title']} #{idx + 1}"
            #User.new(idx, job['title'])
        end
        #jobs
    end

end

puts GitApi.new.get_response

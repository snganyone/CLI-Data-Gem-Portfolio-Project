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
            #{wer, rds}
            title = job['title']
            type = job['type']
            url = job['url']
            description = job['description']
            #Convert HTML to text!
            desc = Html2Text.convert(description)
            location = job['location']
            id = idx + 1
            #Create Job instances
            Job.new(id, title, type, url, location, desc)
        end
    end

end

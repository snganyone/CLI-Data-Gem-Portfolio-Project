class Job
    attr_reader :title, :id, :description, :url, :type, :location
    @@all = []

    def initialize(id, title, type, url, location, description)
        @id = id
        @title = title
        @type = type
        @url = url
        @description = description
        @location = location
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find(id)
        self.all[id-1]
    end
end
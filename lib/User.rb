class User
    attr_reader :title, :id, :description, :url, :type, :location
    @@all = []

    def initialize(id=nil, title=nil)
        @id = id
        @title = title
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find(id)
        self.all[id-1]
    end
end
require 'excon'
require 'colorize'

class GitCli

    def run
        self.welcome
    end


    def welcome
        puts "Welcome to Github Jobs"
    end
end
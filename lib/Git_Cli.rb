require 'excon'
require 'colorize'

class GitCli

    def run
        welcome
        main
    end
    # Displays a welcome message
    def welcome
        puts "Welcome to Github Jobs"
    end

    def goodbye
        puts "Thanks for visiting. Goodbye..."
    end

    #Handles input and output
    def main
    end
end
require 'excon'
require 'colorize'

class GitCli

    def run
        welcome
        spinner
        
        goodbye
        main
    end
    # Displays a welcome message
    def welcome
        puts "Welcome to Github Jobs"
    end

    def goodbye
        puts "Thanks for visiting. Goodbye..."
    end

    # Prints a text-based "spinner" element while work occurs.
    def spinner
        spinner = Enumerator.new do |e|
            loop do
            e.yield '|'
            e.yield '/'
            e.yield '-'
            e.yield '\\'
            end
        end
        
        1.upto(20) do |i|
            printf("\r Loading %s", spinner.next)
            sleep(0.1)
        end
        puts "\n"
    end

    #Handles input and output
    def main
    end
end
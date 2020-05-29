require 'excon'
require 'colorize'

require_relative './Git_Api.rb'

class GitCli
    #Handles Input and Output

    def run
        welcome
        spinner
        GitApi.new.create_jobs
        main
        goodbye
    end

    
    def main
        print_jobs
        prompt
        input
    end

    # Print Messages

    # Displays a welcome message
    def welcome
        puts "Welcome to Github Jobs"
    end

    # Displays a goodby message
    def goodbye
        puts "Thanks for visiting. Goodbye..."
    end

    #Prints Job Postings
    def print_jobs
        listings = Job.all.each{|post| puts "#{post.id} #{post.title}"}
    end


    # I/O
    def prompt
        puts "Please select a position by its number to learn more"
    end

    def input
        gets.chomp
    end

    #Checks if input is valid
    def valid_id?(id)
        id = id.to_i #converts id to an integer value
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
end
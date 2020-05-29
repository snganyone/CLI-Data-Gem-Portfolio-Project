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
    end

    # Displays a welcome message
    def welcome
        puts "Welcome to Github Jobs"
    end

    def goodbye
        puts "Thanks for visiting. Goodbye..."
    end

    def print_jobs
        listings = Job.all.each{|post| puts "#{post.id} #{post.title}"}
    end

    def prompt
        puts "Please select a position by its number to learn more"
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
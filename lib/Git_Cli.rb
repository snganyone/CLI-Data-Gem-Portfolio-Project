require 'excon'
require 'colorize'

require_relative './Git_Api.rb'

class GitCli
    #Handles Input and Output

    def run
        welcome
        spinner
        GitApi.new.create_jobs
        print_jobs
        main
    end

    
    def main
        prompt
        id = valid_id?(input)
        job_post = job_details(id)
        display_details(job_post)
        continue
        choice?(continue_search)
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

    def print_error
        puts "Invalid selection please try again!"
    end

    def continue
        puts "Would you like more information about another job posting? (yes/no)"
    end


    # I/O
    def prompt
        puts "Please select a position by its number to learn more"
    end

    def input
        gets.chomp
    end

    def continue_search
        gets.chomp
    end

    def choice?(answer)
        if answer == 'yes'
            main
        else
            goodbye
        end
    end
    
    def job_details(id)
        selection = Job.find_by_id(id)
        selection
    end

    def display_details(post)
        puts "#{post.title}"
        puts "#{post.type}"
        puts "#{post.location}"
        puts "#{post.description}"
    end
    

    #Checks if input is valid
    def valid_id?(id)
        id = id.to_i #converts id to an integer value
        if id < 1 || id > Job.all.size
            print_error
            sleep(0.5)
            main
        end
        id
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
require 'excon'
require 'colorize'
require 'rainbow'

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
        puts Rainbow("Welcome to Github Jobs").indianred.bright.underline
    end

    # Displays a goodby message
    def goodbye
        puts Rainbow("Thanks for visiting. Goodbye...").indianred.bright.underline
    end

    #Prints Job Postings
    def print_jobs
        listings = Job.all.each{|post| puts Rainbow("#{post.id} #{post.title}").cyan}
    end

    #Prints an Error when input is invalid
    def print_error
        puts "Invalid selection please try again!"
    end
    
    #Loops over main if user selects another job
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

    #Displays Job Details/Information
    def display_details(post)
        puts Rainbow("***********************************").green
        puts Rainbow("Position: #{post.title}").peru
        puts ""
        puts Rainbow("Job Type: #{post.type}").peru
        puts ""
        puts Rainbow("Location: #{post.location}").peru
        puts ""
        puts Rainbow("URL: #{post.url}").peru
        puts ""
        puts Rainbow("Description: #{post.description}").peru
        puts Rainbow("***********************************").green
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

end
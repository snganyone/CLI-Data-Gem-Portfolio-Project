class GitCli
    #Handles Input and Output

    def run
        welcome
        spinner
        GitApi.new.create_jobs
        main
        #Write a blog post explaining difference between each and map?
        #After see the job list should be able to exit
        #Should be able to see the list /(list command) after saying yes
    end
    
    def main
        print_jobs
        prompt
        id = validate_id(input)
        if id == false
            main
        else
            job_post = job_details(id)
            display_details(job_post)
            choice?(continue_search)
        end
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

    
    #Prints an Error when input is invalid
    def print_error
        puts "Invalid selection please try again!"
    end
    
    #Loops over main if user selects another job
    def continue
        puts "Would you like more information about another job posting? (yes/no)"
    end

    #Prints Job Postings
    def print_jobs
        Job.all.each{|post| puts Rainbow("#{post.id} #{post.title}").cyan}
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

    # I/O
    def prompt
        puts "Please select a position by its number to learn more"
    end

    def input
        gets.chomp
    end

    def continue_search
        continue
        gets.chomp
    end

    def choice?(answer)
        if answer == 'yes'
            main
        elsif answer == 'exit'
            goodbye
        else
            goodbye
        end
    end
    
    def job_details(id)
       Job.find_by_id(id)
    end
    

    #Checks if input is valid
    def validate_id(id)
        id = id.to_i #converts id to an integer value
        if id < 1 || id > Job.all.size
            print_error
            sleep(0.5)
            false
        else
            id
        end
    end


    def search
        prompt
        choice = gets.chomp
        if choice == 'exit'
            goodbye
        end
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
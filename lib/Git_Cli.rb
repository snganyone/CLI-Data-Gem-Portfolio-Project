class GitCli
    #Handles Input and Output

    def run
        welcome
        spinner
        GitApi.new.create_jobs
        #opening_question
        main
        #After see the job list should be able to exit
        #Should be able to see the list /(list command) after saying yes/displaying job details
        continue
    end
    
    def main
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

    # def opening_question
    #     puts "Would you like to see our available job postings? (yes/no)"
    # end

    # Displays a goodbye message
    def goodbye
        puts Rainbow("Thanks for visiting. Goodbye...").indianred.bright.underline
    end

    
    #Prints an Error when input is invalid
    def print_error
        puts Rainbow("Invalid selection please try again!").red
    end
    
    #Loops over main if user selects another job
    def continue
        puts "Would you like more information about another job posting? (yes/no)"
       # puts "Would you like to see our available job postings? (yes/no)"
        choice = gets.chomp
        if choice == 'yes' || choice == 'list'
            main
        elsif choice == 'no'
            goodbye
            exit
        elsif choice == 'exit' || choice == ''
            exit
        else
            print_error
            sleep 1
            continue
        end
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
        # #puts "Would you like to see our available job postings? (yes/no)"
        # choice = gets.chomp
        # if choice == 'yes' || choice == 'list'
            print_jobs
            puts "Please select a job posting by ID"
        # elsif choice == 'no'
        #     goodbye
        #     exit
        # elsif choice == 'exit' || choice == ''
        #     exit
    #end
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
        elsif answer == 'list'
            print_jobs
            main
        elsif answer == 'exit'
            exit
        else
            goodbye
        end
    end
    
    def job_details(id)
       Job.find_by_id(id)
    end
    

    #Checks if input is valid
    def validate_id(answer)
        id = answer.to_i #converts id to an integer value            
        type = answer.class
        if type == String && answer == 'exit' || answer == 'no' || answer == ''
            exit
        elsif id < 1 || id > Job.all.size
            print_error
            sleep(0.5)
            false
        else
            id
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
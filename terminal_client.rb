require_relative 'lib/task-manager.rb'
require 'io/console'

@client_list = TM::Database.new

welcome = "Welcome to Project Manager Pro."
help = "Please enter a valid command
        Available Commands:
           help - Show these commands again
           project list - List all projects
           project history PID - Show completed tasks for project PID
           project employees PID - Show employees participating in this project
           project recruit PID EID - Adds employee EID to participate
           project create NAME - Create a new project with name=NAME
           add DESC PID PRIORITY - Add a new task to project with id=PID
           show PID - Show remaining tasks for project with id=PID
           mark TID - Mark task with id=TID as complete
           history PID - show completed tasks for a project with id=PID\n"

puts welcome
puts "Press enter to view valid commands"
doNothing = gets.chomp
puts help
answer = gets.chomp

user_input_arr = answer.split

while answer != "quit" do
  if answer == "help"
    puts help
    answer = gets.chomp
    user_input_arr = answer.split

  # <-- LIST PROJECTS -->
  elsif answer == "project list"
    puts "\nPROJECTS:"
    @client_list.projects.each do |project|
      puts "Project Name: #{project.name}, Project ID: #{project.id}"
    end

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- CREATE A PROJECT -->

  elsif (user_input_arr[0] == "project") && (user_input_arr[1] == "create")
    newarray = user_input_arr[2..-1]
    this_is_it = newarray.join(' ')
    @client_list.create_project(this_is_it)
    puts "\n#{@client_list.projects} was successfully created"

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- ADD A TASK -->
  elsif user_input_arr.first == "add"
    newarray = user_input_arr[1..-1]
    priority = newarray[-1]
    p_id = newarray[-2]
    desc = newarray[0..-3].join(" ")
    @client_list.add_new_task(desc, p_id, priority)
    puts "\n#{desc} was successfully added to the #{@client_list.projects.last.name} project"

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- SHOW REMAINING TASKS FOR A PROJECT -->
  elsif user_input_arr.first == "show"
    p_id = user_input_arr[-1].to_i
    the_project = @client_list.projects.find {|project| project.id == p_id}
    the_project.retrieve_incomplete.each {|task| puts "Task ID: #{task.id}, #{task.description}"}

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- MARK A TASK COMPLETED -->
  elsif user_input_arr.first == "mark"
    t_id = user_input_arr[-1].to_i
    the_project = @client_list.projects.find do |project|
                    project.tasks.find do |task|
                      task.id == t_id
                    end
                  end
    the_project.task_completed(t_id)
    puts "\nTask with id #{t_id} was successfully marked completed"

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- SHOW COMPLETED TASKS FOR A PROJECT -->
  elsif user_input_arr.first == "history"
    p_id = user_input_arr[-1].to_i
    the_project = @client_list.projects.find {|project| project.id == p_id }
    the_project.retrieve_completed.each {|task| puts "Task ID: #{task.id}, #{task.description} has been completed"}

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split

# <-- INVALID TERMINAL INPUT -->
  else
    puts "\nSorry, that's not a valid command."
    puts "\nWhat would you like to do next?"
    answer = gets.chomp
    user_input_arr = answer.split
  end



  # end

end

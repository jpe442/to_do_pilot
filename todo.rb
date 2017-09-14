# Modules

module Menu

	def menu
		"--Welcome to TaskMaster--
		Please choose from one of the following options...
		1. Add a Task
		2. Show All Tasks
		3. Delete a Task
		4. Update a Task
		5. Mark a Task as Complete
		6. Write Current List to File
		7. Read A List from File
		8. Quit Program"
	end

	def show
		menu
  end

	def prompt(message = 'What would you like to do?', symbol = ':>')
		print message
		puts "\n<enter <m> to view menu options>"
		print symbol
		gets.chomp
	end
end


# Classes
class List
	# create a list
	attr_accessor :name, :tasks

	def initialize(name)
		@name = name
		@tasks = []
	end
	# add a task to a list
	def add_task(task)
		@tasks << task
	end

	# show all tasks of a list
	def show_tasks
		puts "here are the tasks on the #{self.name} list..."
		@tasks.map.with_index {|task, i| puts "#{i.next}. " + task.description + " | complete: " + task.status.to_s}
		puts "\n"
	end

	# read a task from a file
	def read_from_file(filename = "listsave")
		IO.readlines(filename).each do |line|
			add_task(Task.new(line.chomp))
		end
	end

	# write a task to a file
	def write_to_file(filename = "listsave")
		IO.write(filename, @tasks.map(&:to_s).join("\n"))
		puts "List has been successfully saved to #{filename}..."
	end


	# delete a task
	def delete_task
		self.show_tasks
		puts "Which task would you like to delete?"
		task_num = gets.chomp
		@tasks.slice!(task_num.to_i-1)
	end

	# update a task

  def update_task
  	self.show_tasks
  	puts "Which task would you like to update?"
  	task_num = gets.chomp
  	puts "What is the new description of this task?"
  	new_description = gets.chomp
  	@tasks[task_num.to_i-1].description = new_description
  	puts "Task #{task_num} has been updated..."
	end

	def mark_complete
		self.show_tasks
		puts "Which task has been completed?"
		task_num = gets.chomp
		@tasks[task_num.to_i-1].status = true
	end

end

class Task

	attr_accessor :name, :description, :status

	def initialize(description = gets.chomp, status = false)
		@description = description
		@status = status
	end

	def to_s
		description
	end

end

	if __FILE__ == $PROGRAM_NAME
		include Menu
		my_list = List.new("example")
		puts "you have created a new list called #{my_list.name}"
		puts my_list.show
		while true 
			input = my_list.prompt.downcase
			case input
				when "m"
					system('clear')
					puts my_list.show
				when "1"
					system('clear')
					puts "Please enter a description for this task..."
					new_task = Task.new
					my_list.add_task(new_task)
				when "2"
					system('clear')
					my_list.show_tasks
				when "3"
					system('clear')
					my_list.delete_task
				when "4"
					system('clear')
					my_list.update_task
				when "5"
					my_list.mark_complete
				when "6"
					my_list.write_to_file
				when "7"
					puts "This will add the tasks from the saved list to current list."
				  puts "Enter 'y' to confirm..."
							 if gets.chomp.downcase == "y"
							   my_list.read_from_file
							 else 
							   puts "Okay...not adding from file"
							 end
				when "8"
					system('clear')
					puts "thanks for using TaskMaster..."
					exit
				else
					system('clear')
					puts "I don't understand that input...\nPlease enter 1,2, or 3..."
			end
		end
	end





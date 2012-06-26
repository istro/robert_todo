module Todo
  class List
    def initialize(file_path)
      @file_path = file_path
      @tasks = parse_tasks(File.read(@file_path))
    end

    def parse_tasks(text)
      # we use #collect here so that we will return an array of tasks
      text.split("\n").collect do |line|
        Task.from_string(line.split[1..-1].join(' '))
      end
    end

    def print_tasks(options)
      case options[:status]
      when :incomplete
        # choose only the tasks that are incomplete
        # in long form this would look like:
        # tasks = @tasks.select { |task| task.incomplete? }
        tasks = @tasks.select(&:incomplete?)
      when :complete
        tasks = @tasks.select(&:complete?)
      else
        # if we're not passed either of the above print options, we'll print them all
        tasks = @tasks
      end
      # task_strings accepts a block and yields a formatted string for each task
      task_strings(tasks) { |string| print string }
    end

    def add_task(title)
      @tasks << Task.new(title)
      write_tasks
    end

    def delete_task(index)
      @tasks.delete_at(index-1)
      write_tasks
    end

    def complete_task(index)
      @tasks[index-1].complete!
      write_tasks
    end

    def write_tasks
      File.open(@file_path, 'w') do |file|
        # using the task_strings method again, this time to write the strings to a file
        task_strings { |string| file.write(string) }
      end
    end

    def task_strings(tasks=nil)
      tasks ||= @tasks
      tasks.each_with_index do |task, index|
        yield "#{index+1}. #{task}\n"
      end
    end
  end
end

# this is our main file where the execution happens

require './list.rb'
require './task.rb'

list = Todo::List.new('./todo.txt')
print_options = {}
case ARGV[0]
when '-a'
  list.add_task(ARGV[1..-1].join(' '))
when '-d'
  list.delete_task(Integer(ARGV[1]))
when '-c'
  list.complete_task(Integer(ARGV[1]))
when '-i' # print incomplete tasks
  print_options[:status] = :incomplete
when '-f' # print completed tasks
  print_options[:status] = :complete
end

list.print_tasks(print_options)

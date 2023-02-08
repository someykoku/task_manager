puts require_relative '../app/models/proc_list/process.rb'
puts require_relative '../app/models/proc_list/table.rb'
puts require_relative '../app/views/table_view.rb'
puts require_relative '../lib/beholder/observer.rb'
puts require_relative '../lib/beholder/producer.rb'


puts ProcList::Process.list 


table = ProcList::Table.new
table_view = TableView.new(table)

loop do 
  table.refresh!
  sleep 1
  `clear`
end



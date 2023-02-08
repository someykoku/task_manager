task default: %w[run]

task :run do
  begin
    require_relative 'lib/beholder/observer.rb'
    require_relative 'lib/beholder/producer.rb'
    ruby "bin/run.rb"
  rescue => error
    puts "Error: #{error}"
  end
end
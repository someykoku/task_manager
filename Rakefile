task default: %w[run]

task :run do
  begin
    ruby "bin/run.rb"
  rescue => error
    puts "Error: #{error}"
  end
end
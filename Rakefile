# frozen_string_literal: true

task default: %w[run]

task :run do
  ruby 'bin/run.rb'
rescue StandardError => e
  puts "Error: #{e}"
end

# frozen_string_literal: true

require 'io/console'
require 'curses'

require_relative '../lib/application/window'
require_relative '../lib/application/input'
require_relative '../lib/application/application_logger'
require_relative '../app/models/proc_list/process'
require_relative '../app/models/proc_list/processes_table'
require_relative '../app/views/table_view'
require_relative '../lib/beholder/observer'
require_relative '../lib/beholder/producer'
require_relative '../lib/application'
require_relative '../lib/application/base_controller'
require_relative '../app/controllers/process_table_controller'

require 'pry'

pry

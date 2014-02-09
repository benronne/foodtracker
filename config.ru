require './foodtracker'
run Sinatra::Application
config.time_zone = 'New York'
config.active_record.default_timezone = :local
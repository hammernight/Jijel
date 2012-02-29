require './automation_web'
Dir["./routes/*.rb"].each {|file| require file }
Dir["./models/*.rb"].each {|file| require file }
Dir["./helpers/*.rb"].each {|file| require file }

run AutomationWeb
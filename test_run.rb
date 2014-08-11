require 'pp'
require_relative 'honekuru'

h = Honekuru.new

10.times do
  puts '----------------'
  puts h.title
  puts h.body
  print h.user_name
  puts " -- #{h.created_at}"
  puts "https://pplog.net/u/#{h.user_name.gsub('@', '')}"
  h.rezap!
  sleep 2
end

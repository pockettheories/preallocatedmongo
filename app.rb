require 'active_support/all'
require 'mongo'

client = Mongo::Client.new 'mongodb://localhost'
client = client.use 'test'

curr_ts = Time.now
curr_date = Date.new(curr_ts.year, curr_ts.month, curr_ts.day)

loop {
  plan = []
  7.times {|i|
    plan[i] = rand(7..12)
  }

  client[:weekplan].update_one(
    {_id: curr_date},
    {"$set": {target: plan}},
    upsert: true
  )

  puts "Inserted weekly plan for the week of #{curr_date}"

  curr_date = 7.days.before(curr_date)
  sleep 10
}

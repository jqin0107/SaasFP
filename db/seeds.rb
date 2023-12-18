# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
events = [{:title => 'Halloween Night', :tag => 'Others', :date => '31-Oct-2023', :location => 'Mudd', :open_status=>'Open'},
{:title => 'NWC Study', :tag => 'Computer Science', :date => '30-Dec-2023', :location=>'NWC', :open_status=>'Open'}
]

users = [
	{:user_name => 'tester1', :first_name => 'first tester1', :last_name => 'last tester1', :password => 'tstpwd1'},
	{:user_name => 'tester2', :first_name => 'first tester2', :last_name => 'last tester2', :password => 'tstpwd2'}
]

events.each do |event|
  Event.create!(event)
end


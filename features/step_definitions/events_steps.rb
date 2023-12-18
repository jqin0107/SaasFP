
Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    Event.create event
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following tags: (.*)/ do |uncheck, tag_list|
  tag_list.split(', ').each do |r|
    if uncheck
      uncheck(r)
    else
      check(r)
    end
  end
end

Then /I should see all the events/ do
  # Make sure that all the movies in the app are visible in the table
  Event.all.each do |event|
    step %{I should see "#{event.title}"}
  end
end

Then /^the tags of "(.+)" should be "(.+)"/ do |title, tags|
  event = Event.find_by_title(title)
  visit event_path(event)
  expect(page.body).to match(/Tag: #{tags}/)
end

Then /the location of "(.*)" should be "(.*)"/ do |title, loc|
  expect(Event.find_by_title(title).location == loc)
end

Then /the open_status of "(.*)" should be "(.*)"/ do |title, s|
  expect(Event.find_by_title(title).open_status == s)
end
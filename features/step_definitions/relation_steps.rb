

Given /the following relations exist/ do |relation_table|
  relation_table.hashes.each do |relation|
    act = ActivityUserRelation.create relation
  end
end
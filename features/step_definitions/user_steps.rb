Given /the following users exist/ do |user_table|
    user_table.hashes.each do |user|
      User.create user
    end
  end
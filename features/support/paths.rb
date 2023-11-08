# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def edit_user_path(user_name)
      user_id = User.find_by_user_name(user_name).id
      "/users/#{user_id}/edit"
    end

    def path_to(page_name)
      case page_name
  
      when /^the login page$/ then '/sessions/new'
      when /^the home page$/ then '/events'
      when /^the register page$/ then "/users/new"
      when /^the welcome page$/ then "/users"
      when /^the edit page for "(.*)"$/ then edit_user_path($1)
      when /^the new event page$/ then "/events/new"


      when /^the event edit page for "(.*)"$/
        event_id = Event.find_by(title: $1).id
        edit_event_path(event_id)

      when /^the details page for "(.*)"$/
        event_id = Event.find_by(title: $1).id
        event_path(event_id)

      when /^the user details page for "(.*)"$/
        user_id = User.find_by(user_name: $1).id
        user_path(user_id)
        # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)
  
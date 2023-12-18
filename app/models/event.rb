class Event < ActiveRecord::Base
	validates :title, presence: true
	validates :location, presence: true
	validates :tag, presence: true
	validates :open_status, presence: true

	def self.all_tags
		['Computer Science', 'Speech', 'Business', 'Career Fair', 'Others']
	end

	def self.with_tags(tags_list)
		if tags_list.nil?
			Event.all
		else
			Event.where("tag in(?)", tags_list)
		end
	end
end


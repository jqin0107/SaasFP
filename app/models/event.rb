class Event < ActiveRecord::Base
	validates :title, presence: true
	validates :location, presence: true
	#validates :max_size, presence: true
	#validates :current_size, presence: true
	validates :tag, presence: true
	#validates :open_status, presence: true

	def self.all_tags
		['Computer Science', 'Speech', 'Business', 'Career Fair', 'Others']
	end

	def self.with_tags(tag_list, sort_by)
			Event.where("Tags in(?)", tag_list).order sort_by
	end
end

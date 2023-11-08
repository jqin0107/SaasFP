require 'rails_helper'

describe RelationsController, type: :controller do
  activities = [
    {:event_name => 'Halloween Night', :location => "Butler", :creator_id => 1, :max_size => 10, :current_size =>3, :category => 'Entertainment', :date => '31-Oct-2023', :open_status => "Open"},
    {:event_name => 'Met Sunday', :location => "Central Park", :creator_id => 1, :max_size => 4, :current_size =>4, :category => 'Arts', :date => '30-Oct-2023', :open_status => "Open"},
    {:event_name => 'Study Monday', :location => "Uris", :creator_id => 2, :max_size => 6, :current_size =>2, :category => 'Education', :date => '2-Nov-2023', :open_status => "Open"},
    {:event_name => 'World Cup', :location => "mel's", :creator_id => 2, :max_size => 6, :current_size =>2, :category => 'Entertainment', :date => '22-Nov-2022', :open_status => "Close"},

  ]

  users = [
    {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'},
    {:user_name => 'tester2', :first_name => 'tfn2', :last_name => 'tln2', :password => '12345678'},
  ]

  relations = [
    {:user_id => 2, :activity_id=>4}
  ]




  before do
    session[:user_id] = 1
    users.each do |user|
      User.new(user).save
    end
    relations.each do | r|
      ActivityUserRelation.new(r).save
    end
    activities.each do |activity|
      Activity.new(activity).save
    end
  end


  describe 'join an event successfully' do
    it 'should success' do
      post :create, :activity_id => Activity.find_by(event_name: 'Halloween Night').id, :user_id => 1
      expect(response).to redirect_to(activities_path)
      expect(assigns(:activity).current_size).to eq(4)
    end
  end

  describe 'join an event twice' do
    it 'should failed' do
      post :create, :activity_id => Activity.find_by(event_name: 'Halloween Night').id, :user_id => 1
      post :create, :activity_id => Activity.find_by(event_name: 'Halloween Night').id, :user_id => 1
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'join a closed activity' do
    it 'should failed' do
      post :create, :activity_id => Activity.find_by(event_name: 'World Cup').id, :user_id => 1
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'leave a closed activity' do
    it 'should failed' do
      delete :destroy, :activity_id => Activity.find_by(event_name: 'World Cup').id, :user_id => 1, :id => Activity.find_by(event_name: 'World Cup').id
      expect(response).to redirect_to(activities_path)
    end
  end


  describe 'join a full event ' do
    it 'should failed' do
      post :create, :activity_id => Activity.find_by(event_name: 'Met Sunday').id, :user_id => 1
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'leave an event successfully' do
    it 'should success' do
      post :create, :activity_id => Activity.find_by(event_name: 'Study Monday').id, :user_id => 1
      delete :destroy, :activity_id => Activity.find_by(event_name: 'Study Monday').id, :user_id => 1, :id => Activity.find_by(event_name: 'Halloween Night').id
      expect(response).to redirect_to(activities_path)
      expect(assigns(:activity).current_size).to eq(2)
    end
  end
end
require 'rails_helper'

describe ActivitiesController, type: :controller do
  activities = [
    {:event_name => 'Halloween Night', :location => "Butler", :creator_id => 1, :max_size => 10, :current_size =>3, :category => 'Entertainment', :date => '31-Oct-2023', :open_status => "Open"},
    {:event_name => 'Met Sunday', :location => "Central Park", :creator_id => 1, :max_size => 4, :current_size =>4, :category => 'Arts', :date => '30-Oct-2023', :open_status => "Open"},
    {:event_name => 'Study Monday', :location => "Uris", :creator_id => 2, :location => 'butler library', :max_size => 6, :current_size =>2, :category => 'Education', :date => '2-Nov-2023', :open_status => "Open"},
    {:event_name => 'Halloween Night 2022', :location => "Butler", :creator_id => 1, :max_size => 10, :current_size =>3, :category => 'Entertainment', :date => '31-Oct-2022', :open_status => "Open"},

  ]

  users = [
    {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'},
    {:user_name => 'tester2', :first_name => 'tfn2', :last_name => 'tln2', :password => '12345678'},
  ]

  relations = [
    {:user_id => 1, :activity_id=>1}
  ]




  before do
    session[:user_id] = 1
    users.each do |user|
      User.new(user).save
    end
    activities.each do |activity|
      Activity.new(activity).save
      #post :create, :activity => activity
    end
  end

  describe 'delete an event successfully' do
    it 'should success' do
      delete :destroy, :id => Activity.find_by(event_name: 'Halloween Night').id
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'delete an event without permission' do
    it 'should fail' do
      delete :destroy, :id => Activity.find_by(event_name: 'Study Monday').id
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'create new event successfully' do
    it 'should success' do
      post :create, :activity => {:event_name => 'Korean food', :location => 'ktown', :max_size => 5, :current_size =>2, :category => 'Others', :date => '3-Nov-2022'}
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'show the detail of an event successfully' do
    it 'should success' do
      get :show, :id => Activity.find_by(event_name:'Met Sunday').id
      expect(response).to have_http_status(:success)
      expect(assigns(:activity)).to eq(Activity.find_by(event_name:'Met Sunday'))
    end
  end

  describe 'show the activities board' do
    it 'should success' do
      get :index, :sort_by=>'Date', :categories => {'Entertainment': 1}, :event_status => 'Open'
      expect(assigns(:activities)).to eq([Activity.find_by(event_name: 'Halloween Night')])
      expect(response).to have_http_status(:success)
    end
  end
  describe 'show the activities board' do
    it 'should success' do
      get :index, :sort_by=>'Date', :categories => {'Arts': 1}
      expect(assigns(:activities)).to eq([Activity.find_by(event_name: 'Met Sunday')])
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show the activities board' do

    it 'should success' do
      get :index
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'get the correct organizor name' do

    it 'should success' do
      expect(ActivitiesController.new.send(:get_organizor_name,Activity.find_by(event_name: 'Halloween Night'))).to eq('tfn1 tln1')
    end
  end












  describe 'Updating max size' do
    it 'should update max party size field' do
      get :edit, :id => Activity.find_by(event_name:'Met Sunday').id
      put :update, :id => Activity.find_by(event_name:'Met Sunday').id, :activity => {:max_size => '8'}
      expect(assigns(:activity).max_size).to eq(8)
    end
  end

  describe 'Updating current size' do
    it 'should update current party size field' do
      get :edit, :id => Activity.find_by(event_name:'Met Sunday').id
      put :update, :id => Activity.find_by(event_name:'Met Sunday').id, :activity => {:current_size => '4'}
      expect(assigns(:activity).current_size).to eq(4)
    end
  end

  describe 'Updating date' do
    it 'should update date field' do
      get :edit, :id => Activity.find_by(event_name:'Met Sunday').id
      put :update, :id => Activity.find_by(event_name:'Met Sunday').id, :activity => {:date => '2022-12-1'}
      expect(assigns(:activity).date).to eq('2022-12-1')
    end
  end

  describe 'Updating max size without permission' do
    it 'should fail' do
      get :edit, :id => Activity.find_by(event_name:'Study Monday').id
      put :update, :id => Activity.find_by(event_name:'Study Monday').id, :activity => {:max_size => '12'}
      expect(assigns(:activity).max_size).to eq(6)
    end
  end

  describe 'redirect to new session path when no user exists' do
    it 'should failed' do
      session[:user_id] = nil
      get :edit, :id => '1'
      expect(response).to redirect_to(new_session_path)
    end
  end

end

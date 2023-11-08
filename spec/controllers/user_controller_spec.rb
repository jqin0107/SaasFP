require 'rails_helper'

describe UsersController, type: :controller do

  activities = [
    {:event_name => 'Halloween Night', :creator_id => 1, :max_size => 10, :current_size =>3, :category => 'Entertainment', :date => '31-Oct-2022', :open_status => "Open"},
    {:event_name => 'Met Sunday', :creator_id => 1, :max_size => 4, :current_size =>4, :category => 'Arts', :date => '30-Oct-2022', :open_status => "Open"},
    {:event_name => 'Study Monday', :creator_id => 2, :location => 'butler library', :max_size => 6, :current_size =>2, :category => 'Education', :date => '2-Nov-2022', :open_status => "Open"},
  ]

  users = [
    {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'},
    {:user_name => 'tester2', :first_name => 'tfn2', :last_name => 'tln2', :password => '12345678'},
  ]

  relations = [
    {:user_id => 1, :activity_id=>1}
  ]


  before do
    users.each do |user|
      post :create, :user => user
    end
    activities.each do |activity|
      Activity.new(activity).save
    end
    relations.each do |relation|
      ActivityUserRelation.new(relation).save
    end

  end

  describe 'register new user successfully' do
    it 'should success' do
      post :create, :user => {:user_name => 'tester3', :first_name => 'tfn3', :last_name => 'tln3', :password => '12345678'}
      expect(response).to redirect_to(root_path)
    end
  end



  describe 'show the detail of a user successfully' do
    it 'should success' do
      session[:user_id] = '1'
      post :show, :id => 1
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(User.find_by_id(1))
    end
  end

  describe 'register new user with duplicated name' do
    it 'should success' do
      post :create, :user => {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'}
      expect(response).to redirect_to(new_user_path)
    end
  end

  describe 'delete an event successfully' do
    it 'should success' do
      delete :destroy, :id => User.find_by(user_name: 'tester1').id
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'get user with session key' do
    it 'should success' do
      session[:user_id] = '1'
      get :index
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'get user without session key' do
    it 'should redirect' do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe 'get the user' do
    it 'should success' do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to(new_session_path)
    end
  end



  describe 'edit user profile successfully' do
    it 'should success' do
      session[:user_id] = '1'
      get :edit, :id => '1'
      put :update, :id => User.find_by(user_name: 'tester1').id, :user => {:first_name => "tester1 first name"}
      expect(response).to redirect_to(user_path(1))
      expect(User.find_by(user_name: 'tester1').first_name).to eq('tester1 first name')
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
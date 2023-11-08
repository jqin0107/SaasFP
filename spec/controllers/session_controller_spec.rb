require 'rails_helper'

describe SessionsController, type: :controller do
  users = [
    {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'},
    {:user_name => 'tester2', :first_name => 'tfn2', :last_name => 'tln2', :password => '12345678'},
  ]
  before do
    users.each do |user|
      User.new(user).save
    end
  end

  describe 'login to user successfully' do
    it 'should success' do
      session[:user_id] = nil
      post :create, :user => {:user_name => 'tester1', :password => 'abcdefgh'}
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'login to user with wrong password' do
    it 'should fail' do
      session[:user_id] = nil
      post :create, :user => {:user_name => 'tester1', :password => '12345678'}
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe 'login to user with wrong user_name' do
    it 'should fail' do
      session[:user_id] = nil
      post :create, :user => {:user_name => 'tester3', :password => 'abcdefgh'}
      expect(response).to redirect_to(new_session_path)
    end
  end
end
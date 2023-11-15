require 'rails_helper'

describe EventsController, type: :controller do 
    events = [
        {:title => 'Midterm Study', :tag => 'Computer Science', :date => '25-Oct-2023', :location => "Butler"},
        {:title => 'Halloween', :tag => 'Others', :date => '31-Oct-2023', :location => "Central Park"}
    ]

    users = [
        {:user_name => 'test1', :first_name => 'first tester1', :last_name => 'last tester1', :password => 'abcd'}
    ]

    before do
        session[:user_id] = 1
        users.each do |user|
            User.new(user).save
        end
        events.each do |event|
            Event.new(event).save
        end
    end

    describe 'create new event successfully' do
        it 'should success' do 
            post :create, :event => {:title => 'Korean Food', :tag => 'Social Event', :date => '27-Oct-2023', :location => 'KTown'}
            expect(response).to redirect_to(events_path)
        end
    end

    describe 'create new event with missing field successfully' do
        it 'should success' do 
            post :create, :event => {:title => 'Chinese Food', :date => '28-Oct-2023', :location => 'Flushing'}
            expect(response).to redirect_to(events_path)
        end
    end

    describe 'delete an event successfully' do 
        it 'should success' do
            delete :destroy, :id => Event.find_by(title: 'Midterm Study').id
            expect(response).to redirect_to(events_path)
        end
    end

    describe 'show the detail of an event successfully' do 
        it 'should success' do
            get :show, :id => Event.find_by(title: 'Halloween').id
            expect(response).to have_http_status(:success)
            expect(assigns(:event)).to eq(Event.find_by(title: 'Halloween'))
        end
    end

    describe 'update date' do
        it 'should update date field' do
            get :edit, :id => Event.find_by(title: 'Midterm Study').id
            put :update, :id => Event.find_by(title: 'Midterm Study').id, :event => {:date => '26-Oct-2023'}
            expect(assigns(:event).date).to eq('26-Oct-2023')
        end
    end

    describe 'update location' do
        it 'should update location field' do
            get :edit, :id => Event.find_by(title: 'Midterm Study').id
            put :update, :id => Event.find_by(title: 'Midterm Study').id, :event => {:location => 'Uris'}
            expect(assigns(:event).location).to eq('Uris')
        end
    end

    describe 'update title' do
        it 'should update title field' do
            get :edit, :id => Event.find_by(title: 'Midterm Study').id
            put :update, :id => Event.find_by(title: 'Midterm Study').id, :event => {:title => 'Midterm Group Study'}
            expect(assigns(:event).title).to eq('Midterm Group Study')
        end
    end

    describe 'show the events board' do
        it 'should success' do
          get :index
          expect(response).to have_http_status(:redirect)
        end
    end

end
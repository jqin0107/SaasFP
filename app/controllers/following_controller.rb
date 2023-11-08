class FollowingController < ApplicationController
    def index
      #@sort_by = sort_by
      followees = Follow.where(follower: session[:user_id]).pluck(:followee)
      @activities = Activity.where(creator_id: followees).order sort_by
      # remember the correct settings for next time

    end

    def create
        if Follow.where(follower: params[:follower], followee: params[:followee]).empty?
          Follow.create!(follower: params[:follower], followee: params[:followee])
        end
        flash[:notice] = "Follow sucessfully!"
        redirect_to activities_path
    end

    def destroy
        Follow.where(follower: params[:follower], followee: params[:followee]).destroy_all
        flash[:notice] = "Unfollow sucessfully!"
        redirect_to activities_path
    end

    def sort_by
      params[:sort_by] || session[:sort_by] || 'Date'
    end
end

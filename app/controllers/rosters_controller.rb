class RostersController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user
  
  def index
    #@roster_list = Roster.all
    @admin_roster = User.where(admin: "t")
  end
  
  def new
    @roster = Roster.new
  end
  
  def create
    @roster = Roster.new(roster_params)
    @roster.user = @current_user
    #respond_to do |format|
      if @roster.save
        students = User.find(params[:ids])
        students.each do |s|
          if s.roster_id != @current_user.id
            s.update_attribute(:roster_id, @current_user.id)
          else
            #format.html 
            return redirect_to new_roster_path, 
                              notice: "User(s) already belongs to a class. Please try again."
          end
        end
        #format.html {
        redirect_to roster_path(current_user), notice: "Your roster was created."
      else  
        redirect_to new_roster_path, notice: "Please try again"
      end
    #end
  end
  
  def adduser
    #@roster = Roster.new
    #@roster.user_id = @current_user
     #   @roster.save
        @user = User.find(params[:id])
        @user.update_attribute(:roster_id, @current_user.id)
        redirect_to users_path, notice: "#{@user.name} was added to your roster. "
    #@user.roster_id = @current_user.id
  end
  
  def show
    #if @current_user.rosters.nil?
    #  redirect_to new_roster_path, notice: "Your roster is currently empty"
    #else  
    
    #####@user = User.find(params[:id])
    #####if !@current_user.roster_id.nil?    
    #else
    #  redirect_to users_path
    #end
    #end
    @user = User.find(params[:id])
    @users = User.where(roster_id: @user.id)
  end
  
  def update
  end
  
  def destroy
  end
  
  def removeuser
    #@roster = Roster.find_by(params[:id])
    @user = User.find(params[:id])
    @user.update_attribute(:roster_id, nil)
    redirect_to roster_path, notice: "#{@user.name} was removed from your roster."
  end

  def roster_params
    params.require(:roster).permit(:description)
  end


end


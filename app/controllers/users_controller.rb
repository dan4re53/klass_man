class UsersController < ApplicationController
  before_action :signed_in_user,   only: [:index, :edit, :update, :destroy]
  before_action :correct_user,     only: [:edit, :update]
  before_action :admin_user,       only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page])
    user = User.find_by(params[:id])
    #@rosters = Roster.where(user_id: user.roster_id)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save 
      sign_in @user
      flash[:success] = "Welcome to the Klass Man App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def admin_add
    @user = User.new
  end
  
  def admin_create
    @current_user = current_user
    @user = User.new(user_params)
    if @user.save 
      flash[:success] = "#{@user.name} has been created."
      redirect_to users_path
    else
      render 'admin_add', notice: "Please try again."
    end
  end
  
=begin    if current_user.admin?
      @current_user = current_user
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        redirect_to @current_user, notice: "#{@user.name} was created."
      else
        render 'new'
      end
    else 
      
    end 
=end    
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end
  end
  
  def edit_contact
    @user = User.find(params[:id])
  end
  
  def update_contact
    @user = User.find(params[:id])
    params = user_params
    params.delete(:password)
    if @user.update_attributes(params)
      flash[:success] = "Contact Info Updated."
      redirect_to @user  
    else 
      render 'edit_contact'
    end
  end

  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :grade, :phone, :roster_id)
    end
  
    #def contact_info
    #  params.permit(:grade, :phone, :roster_id)
    #end
  
      # Before filters
        
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

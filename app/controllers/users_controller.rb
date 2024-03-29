class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
  def show
    @user = User.find(params[:id])
    @products = @user.products.paginate(:page => params[:page])
    @title = @user.email
  end

  def new
  	@user = User.new
    @title = "Sign up"
  end

def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      # Handle a successful save.
      redirect_to products_path
    else
      @title = "Sign up"
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
 
  private
  
  	def authenticate
      deny_access unless signed_in?
    end

	def correct_user
    	@user = User.find(params[:id])
      	redirect_to(root_path) unless (@current_user==@user)
    end
end
class UsersController < ApplicationController
# users need to be able to sign up

  get "/users" do
    @starwars = current_user.starwars
    #binding.pry
    erb :"/users/index"
  end

  get "/signup" do
    #shows form to sign up
    erb :"/users/new"
  end

  post "/signup" do
    #handles signing up the user
    #redirect_if_logged_in # make method
    user = User.new(params) #instantiate a user
    # make sure user signs up with valid data
    if !user.save
      #binding.pry
      flash[:message] = user.errors.full_messages.join(" // ")
      redirect "/signup"
    else
      # log them in
      user.save
      flash[:message] = "Signup successful. Please login now."
      session[:user_id] = user.id # this line of code actually logs us in
      redirect "/users"
    end
  end

  get "/login" do # to show the form
    @starwars = Starwar.all
    erb :"/users/login"
  end

  post "/login" do # process the form
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password]) # if user found and authenticated
      session[:user_id] = user.id
      flash[:message] = "Log in successful."
      redirect "/users"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    flash[:message] = "Logout successful."
    #session.delete(:user_id) # delete just the user_id
    redirect "/"
  end

end


  # get "/users/:id" do
  #   user = User.find_by_username(params[:username])
  #   erb :"/show"
  # end

  
  #### which do we need? this or the previous one? or both?
  # get "/users/index" do
  #   redirect_if_not_logged_in
  #   @starwars = Starwar.all
  #   @user = User.find(params["id"]) 
  #   @stories = Starwar.find_by(params["user_id"]) # added 

    
  #   #@users = User.all
  #   @user_by_id = User.find(params["id"])
  #   @user_stories = Starwar.find_by(params["user_id"])

  #   @user_story = []
  #   @starwars.each do |s|
  #     @user_story << s.user_id
  #   end
  #   erb :"/users/index"
  # end
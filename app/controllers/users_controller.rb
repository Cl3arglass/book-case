class UsersController < ApplicationController

  get '/users/:id' do
   redirect_if_not_logged_in
   @user = User.find(params[:id])
   redirect_if_not_correct_user(@user)
   erb :"users/show"
  end

  get '/signup' do
   if logged_in?
    flash[:message] = "Already logged in"
    redirect to '/crates'
   else
    erb :'users/create_user'
   end
 end

 post '/signup' do
   if params[:username] == "" || params[:password] == ""
     flash.now[:message] = "Both a username and password are required"
     erb :'users/create_user'
   else
     @user = User.new(:username => params[:username], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/crates'
   end
 end

 get '/login' do
   if logged_in?
     flash[:message] = "Already logged in"
     redirect to '/crates'
   else
     erb :'users/login'
   end
 end

 post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/crates"
    else
      flash.now[:message] = "Invalid username or password"
      erb :'users/login'
    end
  end

  get '/logout' do
   if logged_in?
     session.destroy
     redirect to '/login'
   else
     redirect to '/'
   end
 end
end

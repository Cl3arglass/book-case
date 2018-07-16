class UsersController < ApplicationController

  get '/users/:id' do
   if !logged_in?
     redirect '/crates'
   end

   @user = User.find(params[:id])
   if !@user.nil? && @user == current_user
     erb :'users/show'
   else
     redirect '/crates'
   end
 end

  get '/signup' do
   if !logged_in?
     erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
   else
     redirect to '/crates'
   end
 end

 post '/signup' do
   if params[:username] == "" || params[:password] == ""
     redirect to '/signup'
   else
     @user = User.new(:username => params[:username], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/crates'
   end
 end

 get '/login' do
   if !logged_in?
     erb :'users/login'
   else
     redirect to '/crates'
   end
 end

 post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/crates"
    else
      redirect to '/signup'
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

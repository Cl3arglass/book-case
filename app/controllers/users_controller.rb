class UsersController < ApplicationController

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

end

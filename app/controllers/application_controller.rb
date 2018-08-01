require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "super_secret"
  end

  get "/" do
    erb :welcome
  end

  helpers do

   def logged_in?
     !!current_user
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   end

   def redirect_if_not_logged_in
     if !logged_in?
       flash[:message] = "Please login"
       redirect "/login"
     end
   end

   def redirect_if_not_my_crate(crate)
     unless crate && crate.user_id == current_user.id
       flash[:message] = "Crate not found"
       redirect "/crates"
     end
   end

   def redirect_if_not_correct_user(user)
     unless !user.nil? && user.id == current_user.id 
       flash[:message] = "User not found"
       redirect "/crates"
     end
   end

 end

end

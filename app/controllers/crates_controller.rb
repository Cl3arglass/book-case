class CratesController < ApplicationController

  get "/crates" do
   if !logged_in?
    redirect "/login"
   else
     @crates = Crate.all
     erb :'crates/index'
   end
 end
end

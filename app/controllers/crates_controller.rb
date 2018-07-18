class CratesController < ApplicationController

  get "/crates" do
   if !logged_in?
    redirect "/login"
   else
     @crates = Crate.all
     erb :'crates/index'
   end
 end

 get "/crates/new" do
   if !logged_in?
    redirect "/login"
   else
    erb :'crates/new'
   end
  end

  get "/crates/:id" do
    if !logged_in?
     redirect "/login"
    else
     @crate = Crate.find(params[:id])
     erb :'crates/show'
    end
  end

  get "/crates/:id/edit" do
     @crate = Crate.find_by(id: params[:id])
    if !logged_in?
     redirect "/login"
   elsif  @crate && @crate.user_id == current_user.id
     erb :'crates/edit'
   else
     flash[:message] = "Crate not found!"
     redirect "/crates"
    end
  end

  post "/crates" do
    if !logged_in?
     redirect "/login"
    else
     Crate.create(params)
     redirect "/crates"
    end
  end

end

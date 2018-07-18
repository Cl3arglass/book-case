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

  patch '/crates/:id' do
   if logged_in?
     if params[:name] == ""
       redirect to "/crates/#{params[:id]}/edit"
     else
       @crate = Crate.find_by_id(params[:id])
       if @crate && @crate.user_id == current_user.id
         if @crate.update(name: params[:name])
           redirect to "/crates/#{@crate.id}"
         else
           redirect to "/crates/#{@crate.id}/edit"
         end
       else
         redirect to '/crates'
       end
     end
   else
     redirect to '/login'
   end
 end

  post "/crates" do
    if logged_in?
      if params[:name] == ""
        redirect to "/crates/new"
      else
        @crate = current_user.crates.build(name: params[:name])
        if @crate.save
          redirect to "/crates/#{@crate.id}"
        else
          redirect to "/crates/new"
        end
      end
    else
      redirect to '/login'
    end
  end

end

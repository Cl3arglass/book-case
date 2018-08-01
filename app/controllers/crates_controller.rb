class CratesController < ApplicationController

  get "/crates" do
   redirect_if_not_logged_in
   @crates = Crate.all
   erb :'crates/index'
  end

  get "/crates/new" do
   redirect_if_not_logged_in
   erb :'crates/new'
  end

  get "/crates/:id" do
   redirect_if_not_logged_in
   @crate = Crate.find(params[:id])
   erb :'crates/show'
  end

  get "/crates/:id/edit" do
   redirect_if_not_logged_in
   @crate = Crate.find_by(id: params[:id])
   redirect_if_not_my_crate(@crate)
   erb :'crates/edit'
  end

  patch '/crates/:id' do
   redirect_if_not_logged_in
   @crate = Crate.find_by_id(params[:id])
   redirect_if_not_my_crate(@crate)
   if params[:name] == ""
     flash.now[:message] = "Invlid Crate"
     erb :"crates/edit"
   else
     @crate.update(name: params[:name])
     redirect to "/crates/#{@crate.id}"
   end
  end

  post "/crates" do
    redirect_if_not_logged_in
    if params[:name] == ""
      flash.now[:message] = "Invalid Crate"
      erb :"crates/new"
    else
      @crate = current_user.crates.build(name: params[:name])
      @crate.save
      redirect to "/crates/#{@crate.id}"
    end
  end

end

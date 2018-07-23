class BooksController < ApplicationController
  get "/books" do
   if !logged_in?
    redirect "/login"
   else
     @books = Book.all
     erb :'books/index'
   end
 end

 get "/books/new" do
   if !logged_in?
    redirect "/login"
   else
    erb :'books/new'
   end
  end

  get "/books/:id/edit" do
   @book = Book.find_by(id: params[:id])
     if !logged_in?
       redirect "/login"
     elsif  @book && @book.crate.user_id == current_user.id
       erb :'books/edit'
     else
       flash[:message] = "Book not found!"
       redirect "/Books"
    end
  end

  get "/books/:id" do
    if !logged_in?
     redirect "/login"
    else
   @book = Book.find(params[:id])
   erb :'books/show'
  end
 end


  post "/books" do
    binding.pry
    if logged_in?
      if params[:name] == "" || params[:name] == "" || params[:crate_id] == nil
        flash[:message] = "Invalid book"
        redirect to "/books/new"
      else
        @book = Book.create(params)
        if @book.save
          redirect to "/books/#{@book.id}"
        else
          redirect to "/books/new"
        end
      end
    else
      redirect to '/login'
    end
  end
end

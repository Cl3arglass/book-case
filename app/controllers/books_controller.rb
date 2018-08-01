class BooksController < ApplicationController
 get "/books" do
   redirect_if_not_logged_in
   @books = Book.all
   erb :'books/index'
 end

 get "/books/new" do
  redirect_if_not_logged_in
  erb :'books/new'
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

  post "/books/:id" do
   if logged_in?
     if params[:name] == "" || params[:author] == ""
       flash[:message] = "Invalid Book!"
       redirect to "/books/#{params[:id]}/edit"
     else
       @book = Book.find_by_id(params[:id])
       if @book && @book.crate.user_id == current_user.id
         if @book.update(name: params[:name], author: params[:author], crate_id: params[:crate_id])
           redirect to "/books/#{@book.id}"
         else
           redirect to "/books/#{@book.id}/edit"
         end
       else
         redirect to '/books'
       end
     end
   else
     redirect to '/login'
   end
 end


  get "/books/:id" do
   redirect_if_not_logged_in
   @book = Book.find(params[:id])
   erb :'books/show'
  end


  post "/books" do
    if logged_in?
      if params[:name] == "" || params[:author] == "" || params[:crate_id] == nil
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

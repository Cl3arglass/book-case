class BooksController < ApplicationController
  get "/books" do
   if !logged_in?
    redirect "/login"
   else
     @books = Book.all
     erb :'books/index'
   end
 end
end

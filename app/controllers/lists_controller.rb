require './config/environment'
require 'rack-flash'

class ListsController < ApplicationController
  use Rack::Flash

  get '/lists' do
    @title = "To-Do Lists"
    if logged_in?
      @user = current_user
      @lists = @user.lists.all
      erb :"/lists/all_lists"
    else
      redirect "/login"
    end
  end

  get '/lists/new' do

  end

  post '/lists' do
    @list = List.new(params)
    if @list.valid? && @list.save
      redirect '/lists'
    else
      redirect "/lists/all_lists"
    end
  end

  get '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      erb :"/lists/show_list"
    else
      redirect '/login'
    end
  end

  delete "/lists/:id/delete" do
    if logged_in?
      @list = List.find(params[:id])
      if @list.user_id == session[:id]
        @list.delete
        flash[:notice] = "You just deleted your review!"
        redirect '/lists'
      else
        flash[:message] = "You do not have permission to delete this list!"
        redirect '/lists'
      end
    else
      redirect '/login'
    end
  end

end

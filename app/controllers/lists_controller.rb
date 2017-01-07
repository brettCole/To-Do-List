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
      @user = current_user
      @task = @list.tasks.all
      erb :"/lists/show_list"
    else
      redirect '/login'
    end
  end

  post '/lists/:id' do
    @list = List.find_by_id(params[:id])
    #@list = @user.lists.find_by_id(params)
    @task = @list.tasks.build(task: params[:task])
    #@task = Task.new(task: params[:task])
    @task.user = current_user
    if @task.valid? && @task.save
      redirect "/lists/#{@list.id}"
    else
      redirect "/lists/#{@list.id}"
    end
  end

  delete "/lists/:id/tasks/:id/delete" do
    if logged_in?
      @task = Task.find(params[:id])
      @task.user_id == session[:id]
        @task.delete
        flash[:notice] = "You just deleted your task!"
        redirect back
    else
        flash[:message] = "You do not have permission to delete this task!"
        redirect back
    end
    redirect '/login'
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

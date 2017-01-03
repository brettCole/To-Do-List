require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    @title = "Signup"
    if logged_in?
      redirect '/tasks'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)
      if @user.valid? && @user.save
        session[:id] = @user.id
        redirect '/tasks'
      else
        flash[:error] = "Already a User! Please Login!"
        redirect '/login'
      end
  end

  get '/login' do
    @title = "Login"
    if !!session[:id]
      redirect '/tasks'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tasks'
    else
      flash[:error] = "Username or Password do not Match!"
      redirect '/login'
    end
  end

  get 'logout' do
    session.clear
    redirect '/login'
  end

end

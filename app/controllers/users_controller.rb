require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController

  get '/signup' do
    @title = "Signup"
    if logged_in?
      redirect '/'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)
      if @user.valid? && @user.save
        session[:id] = @user.id
        redirect '/'
      else
        flash[:error] = "Already a User! Please Login!"
        redirect '/login'
      end
  end

  get '/login' do
    @title = "Login"
    
  end

end

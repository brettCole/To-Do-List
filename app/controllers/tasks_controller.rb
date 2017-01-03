require './config/environment'
require 'rack-flash'

class TasksController < ApplicationController
  use Rack::Flash

  get '/tasks' do
    if logged_in?
      erb :"/tasks/lists"
    else
      redirect "/login"
    end
  end

  get '/tasks/new' do

  end

end

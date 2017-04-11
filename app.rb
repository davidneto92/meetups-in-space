require 'pry'
require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

creation_error = false

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @all_meetups = Meetup.all.order(:name)

  erb :'meetups/index'
end

get '/meetups/new' do
  if session[:user_id].nil?
    flash[:notice] = "You must be signed in to create a meetup."
    redirect '/'
  end

  @new_meetup = Meetup.new
  erb :'meetups/new'
end

post '/meetups/new' do
  params[:new_meetup]["user_uid"] = User.where(id: session[:user_id])[0].uid
  params[:new_meetup]["date_created"] = Time.now
  params[:new_meetup]["attendees"] = User.where(id: session[:user_id])[0].uid
  @new_meetup = Meetup.new(params[:new_meetup])

  if @new_meetup.save
    flash[:notice] = "Meetup created!"
    redirect "/meetups/" + "#{@new_meetup.id}"
  else
    flash.now[:notice] = "Please completely fill out each field."
    erb :'meetups/new'
  end
end

get '/meetups/:id' do
  @current_meetup = Meetup.where(id: params["id"])[0]
  @creator_username = User.where(uid: @current_meetup.user_uid.to_s)[0].username

  attendee_list = @current_meetup.attendees.split(",")
  @attending_users = attendee_list.map { |attendee_uid| User.where(uid: attendee_uid)[0] }

  if !current_user.nil?
    @meetup_creator = (@current_meetup.user_uid.to_s == current_user.uid)
  end

  erb :'meetups/show'
end

post '/meetups/:id' do
  current_meetup = Meetup.where(id: params["id"])[0]

  if current_user.nil?
    flash[:notice] = "You must sign in to join a meetup."
    redirect '/meetups/' + current_meetup.id.to_s
  elsif current_meetup.attendees.include?(current_user.uid)
    flash[:notice] = "You have already joined this meetup."
    redirect '/meetups/' + current_meetup.id.to_s
  else
    current_meetup.attendees += ",#{current_user.uid}"
    current_meetup.save
    flash[:notice] = "You have joined the meetup!"
    redirect '/meetups/' + current_meetup.id.to_s
  end
end

post '/meetups/delete/:id' do
  to_delete = Meetup.where(id: params["id"])[0]
  to_delete.delete
  redirect '/'
end

post '/meetups/edit/:id' do
  @meetup_edit = Meetup.where(id: params["id"])[0]
  binding.pry
  erb :'meetups/edit'
end

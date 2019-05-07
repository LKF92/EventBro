class EventsController < ApplicationController
before_action :authenticate_user, only: [:new, :create]

  def index
    @all_events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new

  end

  def create
    puts params
    @event = Event.create!(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash.now[:danger] = 'You must fill out all required fields'
      render 'new'
    end
  end


  def edit
  end

  def update
  end

  def destroy
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end


end

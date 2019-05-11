class EventsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  before_action :is_admin?, only: [:edit, :update, :destroy]

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
    @event = Event.create!(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash.now[:danger] = 'You must fill out all required fields'
      render 'new'
    end
  end


  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)
      redirect_to event_path(@event.id)
    else
      flash.now[:danger] = 'You must fill out all required fields'
      render 'new'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to root_path

  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end

  def is_admin?
    current_user == Event.find(params[:id]).admin_id
  end

end

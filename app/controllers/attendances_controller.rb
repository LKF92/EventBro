class AttendancesController < ApplicationController
  before_action :is_admin?, only: [:index]

  def index
    @event = Event.find(params[:event_id])
    @all_attendances = Attendance.where(event_id: @event.id)
  end

  def create
    @amount = (Event.find(params[:event_id]).price)*100
    @event = Event.find(params[:event_id])

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    Attendance.create!(attendee_id: current_user.id, event_id: @event.id, stripe_customer_id: customer.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_attendance_path(@event.id)
  end


  def show
    @event = Event.find(params[:event_id])
    @all_attendances = Attendance.all

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def is_admin?
    current_user == Event.find(params[:id]).admin_id
  end
end

class AttendancesController < ApplicationController

  def index
  end

  def create
    @amount = Event.find(params[:event_id]).price
    @event = Event.find(params[:event_id])

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    Attendance.new(attendee_id : current_user.id, event_id: @event.id, stripe_customer_id: customer.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_attendance_path(@event.id)
  end


    if a.save!
      redirect_to


  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

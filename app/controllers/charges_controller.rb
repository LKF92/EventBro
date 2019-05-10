class ChargesController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    # Amount in cents
    @event = Event.find(params[:event_id])


    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @event.price,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })
    # if payment succeed, we create a new intance of Attendance with the customer id. 
    Attendance.create!(event_id: @event.id, attendee_id: current_user.id, stripe_customer_id: customer.id)
    # redirect_to event_path(@event)

  rescue Stripe::CardError => e
    flash[:error] = e.message

  end

end

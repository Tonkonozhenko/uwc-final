class TicketsController < ApplicationController
  inherit_resources
  actions :show

  def create
    @event = Event.find(params[:event_id])

    @tickets = []
    params[:tickets].each do |_, ticket_params|
      ticket_params[:count].to_i.times do
        ticket = Ticket.includes(:ticket_types).new(permitted_params(ticket_params).merge(cc_number: params[:cc_number]))
        ticket.apply_code(params[:code])
        ticket.valid?
        @tickets << ticket
      end
    end

    if @tickets.any?
      if @tickets.all?(&:valid?) && Ticket.bulk_buy(@tickets)
        flash[:notice] = 'Tickets bought. You can view them at email'
        render 'tickets/tickets_bought'
      else
        render 'new'
      end
    else
      redirect_to(@event.present? ? event_path(@event) : root_path)
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'tickets/show'
      end
    end
  end

  def permitted_params(opts = params)
    opts.slice(:ticket_type_id, :name, :email)
  end
end

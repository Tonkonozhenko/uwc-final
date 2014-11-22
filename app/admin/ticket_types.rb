ActiveAdmin.register TicketType do
  menu false

  config.filters = false

  actions :index#, :new, :create, :edit, :update

  form do |f|
    f.inputs do
      f.input :event, collection: current_admin_user.events, input_html: { class: 'select2able' }
      f.input :title
      f.input :price
      f.input :total
      f.input :remained
    end
    f.actions
  end

  controller do
    protected
    def begin_of_association_chain
      if %w[create update].index(params[:action])
        current_admin_user.events.find(params[:ticket_type][:event_id])
      else
        current_admin_user.events.find(params[:event_id])
      end
    end
  end

  permit_params :title, :price, :total, :remained
end

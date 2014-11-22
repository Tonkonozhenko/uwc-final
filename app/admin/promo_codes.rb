ActiveAdmin.register PromoCode do
  menu false

  actions :index, :new, :create, :edit, :update

  filter :code
  filter :discount_percent
  filter :total_applies
  filter :remained_applies

  permit_params :discount_percent, :total_applies, :remained_applies, :code

  form do |f|
    f.inputs do
      f.input :event, as: :select, collection: options_for_select(current_admin_user.events.pluck(:title, :id), promo_code.event.try(:id)), input_html: { id: 'promocodable_select' }
      ticket_types = options_for_select(promo_code.event.ticket_types.pluck(:title, :id), promo_code.ticket_type.try(:id)) rescue []
      f.input :ticket_type, as: :select, collection: ticket_types, input_html: { id: 'ticket_type_select', class: 'select2able' }

      li(class: 'error') do
        p(content_tag :p, 'Please specify event and optionally ticket type', class: 'inline-errors')
      end if resource.errors.messages[:promocodable]

      f.input :code
      f.input :discount_percent
      f.input :total_applies
      f.input :remained_applies
    end

    f.actions
  end

  controller do
    def create
      event_id = params[:promo_code][:event]
      ticket_type_id = params[:promo_code][:ticket_type]
      @promo_code = PromoCode.new(permitted_params[:promo_code])
      @promo_code.promocodable =
          begin
            current_admin_user.events.find(event_id).ticket_types.find(ticket_type_id)
          rescue
            current_admin_user.events.find(event_id) rescue nil
          end
      create!
    end
  end
end

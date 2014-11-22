ActiveAdmin.register Event do
  actions :all, except: [:destroy]

  filter :title
  filter :starts_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :starts_at, as: :datetime_picker
    end

    f.inputs do
      f.has_many :ticket_types, allow_destroy: true do |ff|
        ff.input :title
        ff.input :price
        ff.input :total
        ff.input :remained
      end
    end

    f.actions
  end


  show do |e|
    attributes_table do
      rows :id, :title, :description, :starts_at, :created_at
    end

    panel TicketType.model_name.human(count: 2) do
      table_for e.ticket_types do
        column :title
        column :price
        column :total
        column :remained
      end
    end

    panel PromoCode.model_name.human(count: 2) do
      table_for e.promo_codes do
        column :code
        column :applied_to do |p|
          p.promocodable.title unless p.promocodable_type == 'Event'
        end
        column :discount_percent
        column :old_price do |p|
          p.promocodable.price unless p.promocodable_type == 'Event'
        end
        column :new_price do |p|
          p.promocodable.price * (100.0 - p.discount_percent) / 100 unless p.promocodable_type == 'Event'
        end
        column :total_applies
        column :remained_applies
        column :edit do |p|
          link_to 'Edit', edit_admin_promo_code_path(p)
        end
      end
    end
  end

  controller do
    protected
    def begin_of_association_chain
      current_admin_user
    end
  end

  action_item :only => :show do
    link_to('Add promo code', new_admin_promo_code_path)
  end

  permit_params :title, :description, :starts_at, ticket_types_attributes: [:id, :title, :price, :total, :remained, :_destroy]
end

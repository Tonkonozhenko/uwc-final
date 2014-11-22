ActiveAdmin.register Event do
  actions :all, except: [:destroy]

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :starts_at, as: :datetime_picker
    end
    f.actions
  end

  filter :title
  filter :starts_at

  controller do
    protected
    def begin_of_association_chain
      current_admin_user
    end
  end

  permit_params :title, :description, :starts_at
end

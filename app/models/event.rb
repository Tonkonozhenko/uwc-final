# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  description   :text
#  starts_at     :datetime
#  admin_user_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Event < ActiveRecord::Base
  belongs_to :admin_user
  has_many :ticket_types
  accepts_nested_attributes_for :ticket_types, allow_destroy: true
  has_many :own_promo_codes, as: :promocodable, class: PromoCode

  validates_presence_of :title, :description, :starts_at

  def promo_codes
    PromoCode.where(promocodable_id: id, promocodable_type: Event) +
        PromoCode.where(promocodable_id: ticket_type_ids, promocodable_type: TicketType)
  end
end

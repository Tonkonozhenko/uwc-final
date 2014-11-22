# == Schema Information
#
# Table name: ticket_types
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  title      :string(255)
#  price      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#

class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :promo_codes, as: :promocodable, class: PromoCode
end

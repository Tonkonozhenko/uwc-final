# == Schema Information
#
# Table name: ticket_types
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  title      :string(255)
#  price      :decimal(8, 2)
#  total      :integer
#  remained   :integer
#  created_at :datetime
#  updated_at :datetime
#

class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :promo_codes, as: :promocodable, class: PromoCode

  def price_with_promo(code)
    promo_code = find_promo_code(code)

    if promo_code
      price * (100.0 - promo_code.discount_percent) / 100
    else
      price
    end
  end

  def find_promo_code(code)
    code = code.code if code.is_a?(PromoCode)
    promo_codes.where(code: code).first || event.own_promo_codes.where(code: code).first
  end
end

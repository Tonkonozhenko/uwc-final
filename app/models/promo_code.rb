# == Schema Information
#
# Table name: promo_codes
#
#  id                :integer          not null, primary key
#  promocodable_id   :integer
#  promocodable_type :string(255)
#  discount_percent  :integer
#  total_applies     :integer
#  remained_applies  :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class PromoCode < ActiveRecord::Base
  belongs_to :promocodable, polymorphic: true

  validates_presence_of :promocodable
  validates :discount_percent, presence: :true, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 100 }
  validates :total_applies, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :remained_applies, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def event
    promocodable.is_a?(Event) ? promocodable : promocodable.try(:event)
  end

  def ticket_type
    promocodable.is_a?(TicketType) ? promocodable : nil
  end
end

# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  ticket_type_id :integer
#  name           :string(255)
#  email          :string(255)
#  cc_number      :string(255)
#  promo_code_id  :string(255)
#  price          :decimal(8, 2)
#  created_at     :datetime
#  updated_at     :datetime
#

class Ticket < ActiveRecord::Base
  attr_accessor :count

  belongs_to :ticket_type
  belongs_to :promo_code

  validates_presence_of :ticket_type, :name, :email
  validate :check_promo_code
  validates_format_of :email, with: Devise.email_regexp
  validate :check_cc_number

  before_save { self.price = ticket_type.price_with_promo(promo_code) }

  def self.bulk_buy(tickets)
    transaction do
      if tickets.all? { |t| (t.ticket_type.remained.blank? || t.ticket_type.remained > 0) &&
          (t.promo_code.present? ? (t.promo_code.remained_applies.blank? || t.promo_code.remained_applies > 0) : true) }
        tickets.all? &:save
      else
        false
      end
    end
  end

  def apply_code(code)
    code = ticket_type.find_promo_code(code)
    self.promo_code = code if valid_promo_code(code)
  end

  protected
  def valid_promo_code(code)
    code = ticket_type.find_promo_code(code) if code.is_a?(String)
    code.nil? || (code.ticket_type == ticket_type || code.event == ticket_type.event)
  end

  def check_promo_code
    if promo_code.present? && !valid_promo_code(promo_code)
      errors.add(:promo_code, I18n.t('errors.messages.invalid'))
    end
  end

  def check_cc_number
    errors.add(:cc_number, I18n.t('errors.messages.invalid')) unless cc_number.present? && verify_luhn(cc_number)
  end

  def verify_luhn(number)
    total = number.gsub(/\s/, '').reverse().split(//).inject([0, 0]) do |accum, n|
      n = n.to_i
      accum[0] += (accum[1] % 2 == 1 ? rotate(n * 2) : n)
      accum[1] += 1
      accum
    end

    (total[0] % 10 == 0)
  end

  def rotate(number)
    if number > 9
      number = number % 10 + 1
    end
    number
  end
end

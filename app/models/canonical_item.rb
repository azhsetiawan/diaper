# == Schema Information
#
# Table name: canonical_items
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  category      :string
#  barcode_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  size          :string
#  item_count    :integer
#  partner_key   :string
#

class CanonicalItem < ApplicationRecord
  has_many :items, dependent: :destroy, inverse_of: :canonical_item, foreign_key: :partner_key, primary_key: :partner_key
  has_many :barcode_items, as: :barcodeable, dependent: :destroy, inverse_of: :canonical_items

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :partner_key, presence: true, uniqueness: true
  validates :weight_in_grams, numericality: { greater_than: 0 }, allow_nil: true

  scope :by_partner_key, ->(partner_key) { where(partner_key: partner_key) }
end

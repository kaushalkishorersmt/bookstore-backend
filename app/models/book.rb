class Book < ApplicationRecord
  belongs_to :author
  monetize :price_paisas

  validates :title, presence: true

  def to_s
    title
  end
end

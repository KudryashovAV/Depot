class Product < ActiveRecord::Base
  has_many :line_item

  before_destroy :ensure_not_refereced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
            with: %r{\.(gif|jpg|png)\z}i,
            message: "URL must point to a picture format GIF, JPG or PNG "
            }

  private

  def ensure_not_refereced_by_any_line_item
    unless line_item.empty?
      errors.add(:base, "There are headings.")
      false
    end
  end
end

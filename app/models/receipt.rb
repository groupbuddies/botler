class Receipt < ActiveRecord::Base
  belongs_to :expense

  mount_uploader :picture, ReceiptPictureUploader

  validates :expense, :picture, presence: true
end

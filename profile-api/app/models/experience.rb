class Experience < ApplicationRecord
  belongs_to :user

  validates_presence_of :start_date, :company, :title

  mount_uploader :company_logo, ImageUploader
end

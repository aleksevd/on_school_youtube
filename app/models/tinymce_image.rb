class TinymceImage < ApplicationRecord
  belongs_to :owner, polymorphic: true

  mount_uploader :file, TinymceImageUploader
end

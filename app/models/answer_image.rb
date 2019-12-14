class AnswerImage < ApplicationRecord
  belongs_to :answer

  mount_uploader :file, AnswerImageUploader
end

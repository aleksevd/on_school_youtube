class Answer < ApplicationRecord
  include Authority::Abilities

  attr_accessor :complete

  belongs_to :user_lesson
  belongs_to :owner, polymorphic: true

  has_many :answer_images, dependent: :destroy

  validate :content_presence

  after_create_commit :change_user_lesson_state

  mount_uploader :audio, AnswerAudioUploader

  accepts_nested_attributes_for :answer_images, reject_if: :all_blank, allow_destroy: true

  def by_teacher?
    owner_type == 'Teacher'
  end

  def by_user?
    owner_type == 'User'
  end

  private

  def content_presence
    if text.blank? && (audio.blank? && errors[:audio].blank?) && no_images?
      errors.add :base, 'Ответ не может быть пустым'
    end
  end

  def no_images?
    answer_images.empty?
  end

  def convert_audio
    Audio::Ogg2mp3.new(self).convert
  end

  def change_user_lesson_state
    if by_teacher?
      if complete
        user_lesson.complete
      else
        user_lesson.give_teacher_answer
      end
    else
      user_lesson.give_answer
    end
  end
end

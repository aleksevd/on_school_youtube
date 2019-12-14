class Lessons::MassUpdate
  def self.create!(lessons_params)
    Lesson.transaction do
      lessons_params.each do |lesson_params|
        Lesson.find(lesson_params[:id]).update!(lesson_params)
      end
    end
  end
end
$ ->
  new Lessons()

class Lessons
  constructor: ->
    @$sortable_container = $('.lessons_sortable')

    @init_sortable()

  init_sortable: =>
    @$sortable_container.sortable
      axis: 'y'
      handle: '.handle'
      stop: =>
        @update()

  update: =>
    data = []

    for lesson, position in @$sortable_container.find('.lesson')
      $lesson = $(lesson)

      lesson_id = $lesson.data('id')
      section_id = $lesson.prevAll('tr.section').data('id')
      lesson_position = position + 1

      data.push
        id: lesson_id
        section_id: section_id
        position: position + 1

      $lesson.find('.position').text(lesson_position)

    @save(data)

  save: (data) =>
    $.ajax
      type: "POST"
      url: @$sortable_container.data('update-url')
      data:
        lessons: data
      dataType: 'json'


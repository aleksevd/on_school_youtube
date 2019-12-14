$ ->
  new Course()

class Course
  constructor: ->
    @init_sortable()

  init_sortable: =>
    $('.sections_sortable').sortable
      axis: 'y'
      handle: '.handle'
      stop: =>
        @recount_positions()

  recount_positions: =>
    $inputs = $('.sections_sortable .course_sections_position input')

    for input, position in $inputs
      $(input).val(position + 1)


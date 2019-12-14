$ ->
  if $('form.sound-recorder').length > 0
    new SoundRecorder()

class SoundRecorder
  constructor: ->
    @$errorsBlock = $('form .errors_block')
    @$form = $('form.sound-recorder')

    # set up basic variables for app
    record = document.querySelector('.record')
    stop = document.querySelector('.stop')

    $record = $(record)
    $stop = $(stop)

    globalThis = @

    @initFormUpload()

    soundClips = document.querySelector('.sound-clips')

    if navigator.mediaDevices.getUserMedia
      console.log 'getUserMedia supported.'
      chunks = []

      onSuccess = (stream) ->
        mediaRecorder = new MediaRecorder(stream)

        record.onclick = ->
          mediaRecorder.start()
          console.log mediaRecorder.state
          console.log 'recorder started'

          $record.toggleClass('hidden', true)
          $stop.toggleClass('hidden', false)
          return

        stop.onclick = ->
          mediaRecorder.stop()
          console.log mediaRecorder.state
          console.log 'recorder stopped'

          $record.toggleClass('hidden', false)
          $stop.toggleClass('hidden', true)

          return

        mediaRecorder.onstop = (e) ->
          console.log 'data available after MediaRecorder.stop() called.'

          clipContainer = document.createElement('article')
          audio = document.createElement('audio')
          deleteButton = document.createElement('button')
          clipContainer.classList.add 'clip'
          audio.setAttribute 'controls', ''
          deleteButton.textContent = 'Delete'
          deleteButton.className = 'delete btn btn-danger btn-xs'

          clipContainer.appendChild audio
          clipContainer.appendChild deleteButton

          $(soundClips).html(clipContainer)

          audio.controls = true

          globalThis.blob = new Blob(chunks, 'type': 'audio/ogg; codecs=opus')

          chunks = []
          audioURL = window.URL.createObjectURL(globalThis.blob)
          audio.src = audioURL
          console.log 'recorder stopped'

          deleteButton.onclick = (e) ->
            evtTgt = e.target
            evtTgt.parentNode.parentNode.removeChild evtTgt.parentNode
            globalThis.blob = null
            return

          return

        mediaRecorder.ondataavailable = (e) ->
          chunks.push e.data
          return

        return

      onError = (err) ->
        console.log 'The following error occured: ' + err
        return

      navigator.mediaDevices.getUserMedia(audio: true).then onSuccess, onError
    else
      console.log 'getUserMedia not supported on your browser!'

  initFormUpload: ->
    @$form.on 'submit', (e) =>
      if @blob?
        e.preventDefault()

        formData = new FormData(e.target)
        formData.append('answer[audio]', @blob, 'audio.ogg')

        $.ajax
          url: @$form.data('api-url')
          type: 'POST'
          data: formData
          contentType: false
          processData: false
          success: (data) ->
            document.location.reload()
          error: (data) =>
            @$errorsBlock.text("Не удалось сохранить ответ. #{data.responseJSON.join('. ')}")
            @$form.find('input[type=submit]').prop('disabled', false)

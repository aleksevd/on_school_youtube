$ ->
  new LightboxPreview()

class LightboxPreview
  constructor: ->
    @initLightbox()

  initLightbox: =>
    lightbox.option
      resizeDuration: 200,
      fadeDuration: 200,
      imageFadeDuration: 200,
      wrapAround: true
      albumLabel: ''

    lightbox.init()
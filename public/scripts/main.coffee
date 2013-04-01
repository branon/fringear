# Require.js allows us to configure shortcut alias to scripts
# These will be usefull when requiring them later
require.config(
  paths:
    jQuery: 'lib/jquery/jquery.req'
    jquery_js: 'lib/jquery/jquery'
    Underscore: 'lib/underscore/underscore.req'
    underscore_js: 'lib/underscore/_'
    Backbone: 'lib/backbone/backbone.req'
    backbone_js: 'lib/backbone/backbone'
    WebAudio: 'lib/webaudio/webaudio.req'
    webaudio_js: 'lib/webaudio/webaudio'
  shim:
    jQuery:
      deps: []
      exports: 'jQuery'
    Underscore:
      deps: ['jQuery']
      exports: '_'
    Backbone:
      deps: ['jQuery', 'Underscore']
      exports: 'Backbone'
    WebAudio:
      deps: []
      exports: 'WebAudio'
)

require(
  [
    'app'
    'jQuery'
    'WebAudio'
    'Underscore'
    'Backbone'
  ], (App, $, WebAudio) ->


      app = new App();

      # Setup globals
      ((window, document) ->

        window.WebAudio = WebAudio
        window.requestAnimFrame = ((window) ->
          window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          (callback) -> window.setTimeout(callback, 1000 / 60)
        )(window)

        window.app = app

      )(window, document)




      $(document).ready () ->
        app.start()
        setTimeout((() -> window.scrollTo(1, 0)), 250)
)


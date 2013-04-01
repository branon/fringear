#Main Application file
define(['jQuery'
        'Underscore'
        'Backbone'
        'collections/locations'
        'views/start'], ($, _, Backbone, Locations, StartView) ->


  class App extends Backbone.Model
    #All the router's initialize function
    initialize: =>

      @audio = new WebAudio()

      @locations = new Locations
      @locations.fetch
        success: () =>
          @setupComplete();


    readyToStart: false
    startCalledButNotReady: false

    setupComplete: () =>
      @readyToStart = true
      @start() if @startCalledButNotReady

    masterTick: =>
      @.trigger 'tick'
      requestAnimFrame @masterTick


    start: =>
      if not @readyToStart
        return @startCalledButNotReady = true

      @view = new StartView()

      @masterTick()

  App
)
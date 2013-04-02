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
    frame = 1

    setupComplete: () =>
      @readyToStart = true
      @start() if @startCalledButNotReady


    locationTick: =>
      navigator.geolocation.getCurrentPosition (position) =>
        @position = position.coords
        @.trigger 'locationTick', @position


    masterTick: =>
      # Track the frame
      @frame=(@frame<<1)>>>0;
      if @frame is 0
        @frame=1

      @.trigger 'tick'

      # Once every 32 frames ( ~2/second ) update the location
      if @frame & 0x0000001
        @locationTick()

      requestAnimFrame @masterTick


    start: =>
      if not @readyToStart
        return @startCalledButNotReady = true

      @view = new StartView()

      @masterTick()

  App
)
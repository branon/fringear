#Incude all the models here, then pass them back into the object
define(['jQuery'
        'Underscore'
        'Backbone'
        'text!tmpl/start.ejs'], ($, _, Backbone, templateText) ->

  class StartView extends Backbone.View

    className: 'start-view start'

    state: 0

    initialize: ->

      _.bindAll @
      @template = _.template(templateText)
      @sound = app.audio.createSound()
      loading = $('<span>Loading...</span>').prependTo('body');
      @sound.load 'audio/techno.mp3', () =>
        loading.remove()
        @render()
      , (err) ->
        console.log(err);


    render: ->

      @$el.html @template()
      @$el.appendTo '#app-container'

      @canvas  = @$el.find('#start-canvas')[0]
      @canvas.width  = $(@canvas).width()
      @canvas.height = $(@canvas).height()
      @ctx    = @canvas.getContext "2d"

      @prevRad = @baseRad = (@canvas.width/2)

      @tick()


    clicked: ->
      @state++
      if @state is 1
        app.on 'tick', @tick
        @stopping = false;
        @sound.loop(true).volume(0.3).play()
      if @state is 2
        @$el.addClass('started')
      if @state is 3
        @stop()


    events:
      'click #start-canvas': 'clicked'

    stop: ->
      # Need to do anything?
      {}

    tick: ->


      # clear the canvas
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height);
      @ctx.fillStyle = "rgba(236, 182, 0, 1)";

      baseRad = @prevRad

      if @state is 2 and baseRad > @baseRad/2
        @prevRad = baseRad = @prevRad * .98

      ## If we are stopping
      if @state is 3
        @volumeStart = @sound.volume() if not @volumeStart
        @sound.volume(@sound.volume()*.9)
        @$el.fadeTo(0, Math.max(@sound.volume()/@volumeStart + .01),1)

        if @sound.volume() <= .001
          @teardown();

      ## If we ar moving to the top corner
      if @state is 2
        @sound.volume(@sound.volume()*.9) if @sound.volume() > 0.05


      ## Lets draw some circles
      if @state > 0
        # normalization of the scale
        scale = @sound.amplitude() * .5;


        for i in [1..3]
          # up to you to find the colors you like
          @ctx.strokeStyle = "rgba(236, 182, 0, #{((3-i)/3)*.8 + .2})";
          @ctx.lineWidth = (6 - 2 * i) || 1;
          #ctx.fillStyle = "rgb(250, 0, 0);";
          # draw a circle
          radius  = baseRad + (i*i*1/3) + (Math.pow(i/3,2) * scale * baseRad)
          radius /= 2
          @ctx.beginPath()
          @ctx.arc @canvas.width/2, @canvas.height/2, radius, 0, Math.PI*2, true
          @ctx.closePath()
          @ctx.stroke()

      @ctx.beginPath()
      @ctx.arc @canvas.width/2, @canvas.height/2, baseRad/2, 0, Math.PI*2, true
      @ctx.closePath()
      @ctx.fill()
      @ctx.strokeStyle = "rgba(236, 182, 0, 1)";
      @ctx.stroke()


      # Text Time
      @ctx.lineWidth = 1;
      @ctx.textAlign = 'center'
      @ctx.font = "14pt sans-serif";
      @ctx.strokeStyle = "rgba(0, 0, 0, 1)";
      @ctx.fillStyle = "rgba(255, 255, 255, 1)";

      if @state is 0
        @ctx.strokeText "Press To Start", @canvas.width/2 + 1, @canvas.height/2 + 8
        @ctx.fillText "Press To Start", @canvas.width/2, @canvas.height/2 + 7

      if @state is 1
        @ctx.strokeText "Auburn", @canvas.width/2 + 1, @canvas.height/2 - 1
        @ctx.strokeText "Aumbiance", @canvas.width/2 + 1, @canvas.height/2 + 17

        @ctx.fillText "Auburn", @canvas.width/2, @canvas.height/2 - 2
        @ctx.fillText "Aumbiance", @canvas.width/2, @canvas.height/2 + 16



    teardown: ->
      @off()
      @remove()
      app.off 'tick', @tick
      @sound.destroy?()
      @undelegateEvents()

  StartView
)
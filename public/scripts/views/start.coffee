#Incude all the models here, then pass them back into the object
define(['jQuery'
        'Underscore'
        'Backbone'
        'text!tmpl/start.ejs'], ($, _, Backbone, templateText) ->

  class StartView extends Backbone.View

    className: 'start-view'

    initialize: ->
      _.bindAll @
      @template = _.template(templateText)
      @render()
      @start()



    render: ->

      @$el.html @template()
      @$el.appendTo '#app-container'

      @canvas  = @$el.find('#start-canvas')[0]
      @canvas.width  = $(@canvas).width()
      @canvas.height = $(@canvas).height()
      @ctx    = @canvas.getContext "2d"



    start: ->
      @stopping = false;
      @sound = app.audio.createSound()
      @sound.load 'audio/techno.mp3', (sound) ->
        sound.loop(true).volume(0.3).play()
      app.on 'tick', @tick


    events:
      'click .start': 'stop'

    stop: ->
      @stopping = true;



    tick: ->

      if @stopping
        @volumeStart = @sound.volume() if not @volumeStart
        @sound.volume(@sound.volume()*.9)
        @$el.fadeTo(0, Math.max(@sound.volume()/@volumeStart + .01),1)

        if @sound.volume() <= .001
          @teardown();
      # normalization of the scale
      scale = @sound.amplitude() * .5;

      # clear the canvas
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height);

      @ctx.fillStyle = "rgba(236, 182, 0, 1)";

      for i in [1..3]
        # up to you to find the colors you like
        @ctx.strokeStyle = "rgba(236, 182, 0, #{((3-i)/3)*.8 + .2})";
        @ctx.lineWidth = (6 - 2 * i) || 1;
        #ctx.fillStyle = "rgb(250, 0, 0);";
        # draw a circle
        baseRad = (@canvas.width/2)
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

      # Draw base Circle
      @ctx.beginPath()


    teardown: ->
      @off()
      @remove()
      app.off 'tick', @tick
      @sound.destroy?()
      @undelegateEvents()

  StartView
)
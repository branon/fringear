define(['jQuery'
        'Underscore'
        'Backbone'], ($, _, Backbone) ->

  class Location extends Backbone.Model

    idAttribute: "_id"

    #parse: (response) ->
      #console.log response

  Location
)
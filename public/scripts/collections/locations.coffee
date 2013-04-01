define(['jQuery'
        'Underscore'
        'Backbone'
        'models/location'], ($, _, Backbone, Location) ->

  class Locations extends Backbone.Collection

    url: '/api/locations'
    model: Location

    comparator: (location) ->
      location.get('name')

  Locations
)
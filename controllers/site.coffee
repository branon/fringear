exports = module.exports = (app) ->
  # Home
  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/api/locations', (req, res) ->
    locations = []

    locations.push(
        _id: Math.random()
        lat: 33.76952
        lon: -84.39112
        name: 'North Ave'
        sound: '/audio/roost.mp3'
      )

    locations.push(
        _id: Math.random()
        lat: 33.77071
        lon: -84.39118
        name: 'North Ave 2'
        sound: '/audio/roost.mp3'
      )

    res.json locations

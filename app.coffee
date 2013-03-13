# Main application file
#   Kicks off the whole show
#
app      = (require 'express')()
port     = process.env.PORT or 8080


console.log "\n\nStarting in mode:", app.settings.env

app.config = process.env


# Configuration
require('./lib/settings').boot(app);


# Error Handler
require('./lib/error-handler').boot(app);


# Bootstrap controllers
controller_loc = __dirname + '/controllers'
controller_files = (require 'fs').readdirSync controller_loc
controller_files.forEach (file) ->
  (require controller_loc + '/' + file)(app)



# Start the app by listening on <port>
server = app.listen port
console.log "Express-Boilerplate started on port #{port}"

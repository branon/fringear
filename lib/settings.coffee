express   = require 'express'
fs        = require 'fs'

exports.boot = (app) ->

  app.configure ()->
    app.set 'views', __dirname + '/../views'

    app.set 'view engine', 'ejs'

    app.use express.bodyParser()

    app.use express.methodOverride()

    app.use (req,res,next) ->
      res.header("X-powered-by", "")
      next()

    app.use require('connect-less')(
      src: __dirname + '/../public/'
      compress: true
      yuicompress: true
    )

    app.use require('./coffee-compile')(
      force: true
      src: __dirname + '/../public'
      streamOut: true
    )

    app.use express.compress()

    app.use express.static __dirname + '/../public'

    # Helpers
    (require '../lib/helpers').boot app

    app.use express.favicon()
    app.use app.router


  app.set 'showStackError', false
  app.configure 'development', ()->
    app.use express.errorHandler
      dumpExceptions: true
      showStack: true


  app.configure 'staging', ()->
    app.enable 'view cache'


  app.configure 'production', ()->
    app.enable 'view cache'


  try
    gitHead = fs.readFileSync(__dirname+'/../.git/refs/remotes/origin/master', 'utf-8').trim()
    app.set 'revision', gitHead
  catch e
    app.set 'revision', 'r'+(new Date()).getTime()



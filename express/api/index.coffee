path = require 'path'

express = require 'express'
routesmanager = require 'express-routes-manager'

bodyparser = require 'body-parser'
cookieparser = require 'cookie-parser'
session = require 'express-session'
methodoverride = require 'method-override'
flash = require 'flash'
favicon = require 'serve-favicon'

LOG = require('debug') 'express:db-manager:api'
LOG "init express application"
app = express()
app.on 'mount', (parent) ->
  app.set 'parent', parent
LOG "run routesmanager for app"  
routesmanager app
LOG "use body-parser"
app.use bodyparser.json()
app.use bodyparser.urlencoded
  extended: true
LOG "use cookie-parser"
app.use cookieparser process.env.SECRET_KEY or 'express-db-manager-secret'
LOG "use express-session"
app.use session
  secret: process.env.SECRET_KEY or 'express-db-manager-secret'
  resave: false
  saveUninitialized: true
LOG "use method-override"  
app.use methodoverride()
LOG "use flash"
app.use flash()
LOG "use favicon"
app.use favicon path.resolve __dirname, '..', 'public', 'favicon.ico'
LOG "load routes"
app.loadRoutes require('./routes') app
LOG "export application"
module.exports = app;
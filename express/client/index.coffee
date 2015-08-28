path = require 'path'

express = require 'express'
routesmanager = require 'express-routes-manager'

favicon = require 'serve-favicon'

LOG = require('debug') 'express:db-manager:client'
LOG "init express application"
app = express()
app.on 'mount', (parent) ->
  app.set 'parent', parent
LOG "set views folder"
app.set 'views', path.resolve __dirname, 'views'
LOG "set view engine"
app.set 'view engine', 'jade'
app.locals.pretty = true
LOG "run routesmanager for app"  
routesmanager app
LOG "use favicon"
app.use favicon path.resolve __dirname, '..', 'public', 'favicon.ico'
LOG "use static for public folder"
app.use express.static path.resolve(__dirname, 'public'),
    redirect: false
LOG "load routes"
app.loadRoutes {}
LOG "export application"
module.exports = app;
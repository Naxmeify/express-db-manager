path = require 'path'

express = require 'express'
routesmanager = require 'express-routes-manager'

morgan = require 'morgan'
favicon = require 'serve-favicon'

LOG = require('debug') 'express:db-manager'
manifest = require '../package.json'

LOG "init express application"
app = express()
LOG "set port"
app.set 'port', process.env.PORT or 3000
LOG "set manifest"
app.set 'manifest', manifest
app.use (req, res, next) ->
  res.locals.manifest = manifest
  next()
LOG "run routesmanager for app"
routesmanager app
LOG "use morgan" if app.get('env') is 'development'
app.use morgan 'dev' if app.get('env') is 'development'
LOG "use favicon"
app.use favicon path.resolve __dirname, 'public', 'favicon.ico'
LOG "use static for public folder"
app.use express.static path.resolve(__dirname, 'public'),
    redirect: false
LOG "load routes"
app.loadRoutes
  'mount /api': require './api'
  'mount /': require './client'
LOG "export application"
module.exports = app;
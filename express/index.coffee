path = require 'path'

express = require 'express'
routesmanager = require 'express-routes-manager'

morgan = require 'morgan'
favicon = require 'serve-favicon'

LOG = require('debug') 'express:db-manager'
LOG "init express application"
app = express()
LOG "set port"
app.set 'port', process.env.PORT or 3000
LOG "run routesmanager for app"
routesmanager app
LOG "use morgan" unless app.get('env') is 'production'
app.use morgan 'dev' unless app.get('env') is 'production'
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